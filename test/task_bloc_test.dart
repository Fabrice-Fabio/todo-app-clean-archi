import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todotdd/data/repositories/mock_task_repository.dart';
import 'package:todotdd/domain/entities/task.dart';
import 'package:todotdd/presentation/bloc/task_bloc.dart';
import 'package:todotdd/presentation/bloc/task_event.dart';
import 'package:todotdd/presentation/bloc/task_state.dart';

void main() {
  late TaskBloc taskBloc;
  late MockTaskRepository mockTaskRepository;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    taskBloc = TaskBloc(taskRepository: mockTaskRepository);
  });

  tearDown(() {
    taskBloc.close();
  });

  group('AddTaskEvent', () {
    final testTask = Task(id: '1', title: 'Test task', dueDate: DateTime.now(), description: '');

    test('should emit [TasksLoaded] when task is added', () async {
      when(mockTaskRepository.addTask(testTask)).thenAnswer((_) async => true);
      final expectedResponse = [
        TasksLoaded([testTask]),
      ];
      expectLater(taskBloc.stream, emitsInOrder(expectedResponse));
      taskBloc.add(AddTaskEvent(testTask));
    });
  });
}
