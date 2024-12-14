import 'package:flutter/material.dart';
import '../../Model/shared_preferences/shared_preferences.dart';
import '../../Model/task_model/task_model.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final _taskFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedCategory;
  String? _selectedLevel;
  Color? _selectedColor;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _addTask() {
    if (_taskFormKey.currentState?.validate() ?? false) {
      final newTask = TaskModel(
        nameTask: _nameController.text,
        category: _selectedCategory ?? '',
        level: _selectedLevel ?? '',
        descriptionTask: _descriptionController.text,
        // date: _selectedDate,
        color: _selectedColor,
      );
      SharedPrefsManager.instance.setTask(newTask);
      _resetForm();
      Navigator.pop(context, true);
    }
  }

  void _resetForm() {
    setState(() {
      _nameController.clear();
      _descriptionController.clear();
      _selectedDate = null;
      _selectedCategory = null;
      _selectedLevel = null;
      _selectedColor = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _taskFormKey,
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(_nameController, 'Task Name', TextInputType.name),
              const SizedBox(height: 16),
              _buildTextField(
                _descriptionController,
                'Task Description',
                TextInputType.text,
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              _buildDropdown(
                hint: 'Category',
                value: _selectedCategory,
                items: TaskModel().categories,
                onChanged: (value) => setState(() {
                  _selectedCategory = value;
                }),
              ),
              const SizedBox(height: 16),
              _buildDropdown(
                hint: 'Importance Level',
                value: _selectedLevel,
                items: TaskModel().levels,
                onChanged: (value) => setState(() {
                  _selectedLevel = value;
                }),
              ),
              const SizedBox(height: 16),
              _buildDatePicker(context),
              const SizedBox(height: 16),
              _buildColorPicker(),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _addTask,
                  child: const Text('Add Task'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, TextInputType type,
      {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label is required';
        }
        return null;
      },
    );
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      hint: Text(hint),
      value: value,
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return InkWell(
      onTap: () => _pickDate(context),
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            _selectedDate != null
                ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}' // تنسيق التاريخ يدويًا
                : 'Select Date',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildColorPicker() {
    return Center(
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // لمحاذاة الألوان في المنتصف
          children: TaskModel().colors.map((color) {
            return GestureDetector(
              onTap: () => setState(() {
                _selectedColor = color;
              }),
              child: Container(
                width: 50,
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _selectedColor == color
                        ? Colors.black
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
