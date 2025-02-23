void main() {
  Library library = Library();

  library.addBook(title: "The Hidden Life of Trees", author: "Peter Wohlleben", year: 2015, genre: "Nature");
  library.addBook(title: "Wilding", author: "Isabella Tree", year: 2018, genre: "Nature");
  library.addBook(title: "Desert Solitaire", author: "Edward Abbey", year: 1968, genre: "Memoir");
  library.addBook(title: "The Overstory", author: "Richard Powers", year: 2018, genre: "Fiction");
  library.addBook(title: "A Sand County Almanac", author: "Aldo Leopold", year: 1949, genre: "Nature");

  print(library.getBookInfo(title: "The Hidden Life of Trees"));
  print(library.getBookInfo(title: "Unknown Book"));

  library.listAllBooks();

  library.listAllBooks(genre: "Nature");

  print(library.listBooksByGenre(genre: "Memoir"));
  print(library.listBooksByGenre(genre: "Science"));

  print(library.removeBook(title: "Desert Solitaire"));
  print(library.removeBook(title: "Unknown Book"));

  library.listAllBooks();

}

class Library {
  List<Map<String, dynamic>> books = [];

  void addBook({
    required String title,
    String author = "unknown",
    int year = 0,
    String genre = "public",
  }) {
    books.add({
      "title": title,
      "author": author,
      "year": year,
      "genre": genre,
    });
    print("Book added successfully.");
  }

  String getBookInfo({required String title}) {
    var book = books.where((b) => b["title"] == title).toList();

    return book.isNotEmpty
        ? "Author: ${book.first['author']}, Year: ${book.first['year']}, Genre: ${book.first['genre']}"
        : "Book not found.";
  }


  void listAllBooks({String genre = ""}) {
    if (books.isEmpty) {
      print("No books found.");
      return;
    }

    var filtering = books
        .where((book) => genre.isEmpty || book["genre"] == genre)
        .map((book) => "Title: ${book['title']}, Author: ${book['author']}, Year: ${book['year']}, Genre: ${book['genre']}")
        .toList();

    if (filtering.isEmpty) {
      print("No books found for this genre.");
    } else {
      filtering.forEach(print);
    }
  }

  List<String> listBooksByGenre({required String genre}) {
    var filter = books
        .where((book) => book["genre"] == genre)
        .map((book) => book["title"] as String)
        .toList();

    return filter.isNotEmpty ? filter : ["No books found in this genre."];
  }

  String removeBook({required String title}) {
    var bookToRemove = books.where((b) => b["title"] == title).toList();

    if (bookToRemove.isNotEmpty) {
      books.removeWhere((b) => b["title"] == title);
      return "Book removed successfully: $title";
    }

    return "Book not found.";
  }

}
