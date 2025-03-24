import 'package:flutter/material.dart';

import '../constants/colors.dart';

class SearchableDropdown extends StatefulWidget {
  final List<String> countryCodes;
  final ValueChanged<String?> onChanged;
  final String? selectedCountry;

  const SearchableDropdown({
    Key? key,
    required this.countryCodes,
    required this.onChanged,
    this.selectedCountry,
  }) : super(key: key);

  @override
  _SearchableDropdownState createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredCountries = [];
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _filteredCountries = widget.countryCodes;
    _searchController.addListener(_filterCountries);
  }
bool isVisible=false;
  void _filterCountries() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredCountries = widget.countryCodes;
      } else {
        _filteredCountries = widget.countryCodes
            .where((country) => country
            .toLowerCase()
            .contains(_searchController.text.toLowerCase()))
            .toList();
      }
    });
  }

  void _showOverlay() {
    isVisible=true;
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Size size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 5),
          child: Material(
            elevation: 4,
            child: Container(
              padding: EdgeInsets.all(8),
              color: rBlack,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Search Bar
                  TextFormField(
                    controller: _searchController,
                    focusNode: _focusNode,
                    cursorColor: rGreen,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: rHint.withOpacity(0.5)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 16.0),
                    ),
                    style: TextStyle(color: Colors.white),
                    onChanged: (value) {
                      _filterCountries();
                    },
                  ),
                  // Dropdown Items
                  Container(
                    constraints: BoxConstraints(maxHeight: 200),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _filteredCountries.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            _filteredCountries[index],
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            widget.onChanged(_filteredCountries[index]);
                            _hideOverlay();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context)?.insert(_overlayEntry!);
    _focusNode.requestFocus();
  }

  void _hideOverlay() {
    isVisible=false;
    _overlayEntry?.remove();
    _overlayEntry = null;
    _searchController.clear();
    _filterCountries();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _hideOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: isVisible?_hideOverlay:_showOverlay,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: rHint),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.selectedCountry ?? 'Country',
                style: TextStyle(
                  color: widget.selectedCountry == null
                      ? rHint.withOpacity(0.5)
                      : Colors.white,
                ),
              ),
              Icon(Icons.keyboard_arrow_down, color: rHint),
            ],
          ),
        ),
      ),
    );
  }
}