// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class DevotionalUploadScreen extends StatefulWidget {
  const DevotionalUploadScreen({Key? key}) : super(key: key);

  @override
  _DevotionalUploadScreenState createState() => _DevotionalUploadScreenState();
}

class _DevotionalUploadScreenState extends State<DevotionalUploadScreen> {
  final TextEditingController _devotionalController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  File? _imageFile;
  DateTime? _selectedDate;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _submitDevotional() {
    // TODO: Implement submission logic
    if (_imageFile == null || _selectedDate == null || _devotionalController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    // Here you would typically send the data to your backend
    print('Submitting devotional:');
    print('Date: ${_dateController.text}');
    print('Text: ${_devotionalController.text}');
    print('Image path: ${_imageFile?.path}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Devotional'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Date Selection
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Date',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ),
              readOnly: true,
            ),
            const SizedBox(height: 20),

            // Image Upload
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _imageFile != null
                  ? Stack(
                      children: [
                        Image.file(
                          _imageFile!,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: () => setState(() => _imageFile = null),
                          ),
                        ),
                      ],
                    )
                  : InkWell(
                      onTap: _pickImage,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_photo_alternate, size: 50),
                          Text('Tap to add image'),
                        ],
                      ),
                    ),
            ),
            const SizedBox(height: 20),

            // Devotional Text
            TextField(
              controller: _devotionalController,
              decoration: const InputDecoration(
                labelText: 'Devotional Text',
                border: OutlineInputBorder(),
              ),
              maxLines: 10,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 20),

            // Submit Button
            ElevatedButton(
              onPressed: _submitDevotional,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Upload Devotional',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _devotionalController.dispose();
    _dateController.dispose();
    super.dispose();
  }
}