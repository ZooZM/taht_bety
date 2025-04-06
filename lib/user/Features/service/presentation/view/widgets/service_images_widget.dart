import 'package:flutter/material.dart';

class ServiceImagesWidget extends StatefulWidget {
  const ServiceImagesWidget({super.key, required this.images});
  final List<String> images;

  @override
  State<ServiceImagesWidget> createState() => _ServiceImagesWidgetState();
}

class _ServiceImagesWidgetState extends State<ServiceImagesWidget> {
  int _selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[200],
          ),
          child: widget.images.isEmpty
              ? const Center(
                  child: Icon(Icons.image, size: 50, color: Colors.grey))
              : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.images[_selectedImageIndex],
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) =>
                        const Center(child: Icon(Icons.broken_image, size: 50)),
                  ),
                ),
        ),
        const SizedBox(height: 12),
        if (widget.images.length > 1) ...[
          Text(
            'Service Images',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedImageIndex = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _selectedImageIndex == index
                            ? Theme.of(context).primaryColor
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        widget.images[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}
