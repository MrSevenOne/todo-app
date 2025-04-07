import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/data/repositories/todo_repository.dart';
import '../../data/model/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  TodoProvider() {
    _listenAuthChanges();
    getTodo(); // Dastlab ma'lumotlarni yuklash
  }

  void _listenAuthChanges() {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      getTodo(); // User almashganda avtomatik yangilash
    });
  }

  final TodoRepository _todoRepository = TodoRepository();
  bool _isLoading = false;
  List<TodoModel> _todo = [];
  List<TodoModel> _sortBydate = [];
  List<TodoModel> _doneTodo = [];

  bool get isLoading => _isLoading;

  List<TodoModel> get todo => _todo;

  List<TodoModel> get sortByDate => _sortBydate;
  List<TodoModel> get doneTodos => _doneTodo;

  /// **Ma'lumotlarni qo'shish**
  Future addCollectedTodo({required TodoModel todoModel}) async {
    _setLoading(true);
    try {
      await _todoRepository.addTodo(todomodel: todoModel);
      getTodo();
    } catch (e) {
      print('Add todo error: $e');
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  /// **Barcha ma'lumotlarni olish**
 /// **Barcha ma'lumotlarni olish**
Future getTodo() async {
  _setLoading(true);
  try {
    List<TodoModel> allTodos = await _todoRepository.getTodo();

    // Bajarilgan va bajarilmagan todolarni ajratamiz
    _todo = allTodos.where((todo) => todo.isActive).toList();
    _doneTodo = allTodos.where((todo) => !todo.isActive).toList();

    // Sana bo'yicha tartiblaymiz
    _todo.sort((a, b) => b.deadline.compareTo(a.deadline));
    _doneTodo.sort((a, b) => b.deadline.compareTo(a.deadline));

    notifyListeners();
  } catch (e) {
    print('Get todo error: $e');
  } finally {
    _setLoading(false);
  }
}


  /// todo malumotni edit qilish
  Future editTodo({required TodoModel model}) async {
    _setLoading(true);
    try {
      await _todoRepository.editTodo(model: model); // Yangilashni kutamiz
      await getTodo(); // Yangilangan ma'lumotlarni qayta yuklaymiz
    } catch (e) {
      print('Edit todo error: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// todo bajarildi qilish
  Future doneTodo({required TodoModel todomodel}) async {
    _setLoading(true);
    try {
      await _todoRepository.doneTodo(todomodel: todomodel);
      await getTodo();
    } catch (e) {
      print('Done todo error: $e');
    } finally {
      _setLoading(false);
    }
  }

  doneTodoList() {
     return _doneTodo.where((todo) => todo.isActive == false);
  }

  Future deleteTodo({required int todoId}) async {
    _setLoading(true);
    try {
      await _todoRepository.deleteTodo(todoId: todoId);
      await getTodo();
    } catch (e) {
      print("delete todo error: $e");
    } finally {
      _setLoading(false);
    }
  }

  /// **Berilgan sanaga mos todolarni olish**
  Future getTodoByDate(DateTime date) async {
    _setLoading(true);
    try {
      List<TodoModel> allTodos = await _todoRepository.getTodo();
      _sortBydate = allTodos
          .where((todo) =>
              todo.deadline.year == date.year &&
              todo.deadline.month == date.month &&
              todo.deadline.day == date.day)
          .toList();
      notifyListeners();
    } catch (e) {
      print('Get todo by date error: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// **Priority yig‘indisini olish (isActive bo‘yicha)**
 int getPrioritySum(bool isActive) {
  return (isActive ? _todo : _doneTodo)
      .fold(0, (sum, todo) => sum + todo.priority);
}


  /// **Loading holatini boshqarish**
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
