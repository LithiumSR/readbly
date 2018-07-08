if (typeof kotlin === 'undefined') {
  throw new Error("Error loading module 'bookinfo_kotlin'. Its dependency 'kotlin' was not found. Please, check whether 'kotlin' is loaded prior to 'bookinfo_kotlin'.");
}
var bookinfo_kotlin = function (_, Kotlin) {
  'use strict';
  var throwCCE = Kotlin.throwCCE;
  var Kind_CLASS = Kotlin.Kind.CLASS;
  var equals = Kotlin.equals;
  var Unit = Kotlin.kotlin.Unit;
  var toString = Kotlin.toString;
  var substringBefore = Kotlin.kotlin.text.substringBefore_j4ogox$;
  var toInt = Kotlin.kotlin.text.toInt_pdl1vz$;
  function Book(title, author, cover, publisher, overview, release_year) {
    this.title = title;
    this.author = author;
    this.cover = cover;
    this.publisher = publisher;
    this.overview = overview;
    this.release_year = release_year;
  }
  Book.prototype.updateView = function () {
    var tmp$, tmp$_0, tmp$_1, tmp$_2, tmp$_3, tmp$_4;
    var titleField = Kotlin.isType(tmp$ = document.getElementById('title'), HTMLInputElement) ? tmp$ : throwCCE();
    titleField.value = this.title;
    var authorField = Kotlin.isType(tmp$_0 = document.getElementById('author'), HTMLInputElement) ? tmp$_0 : throwCCE();
    authorField.value = this.author;
    var coverLink = Kotlin.isType(tmp$_1 = document.getElementById('coverlink'), HTMLInputElement) ? tmp$_1 : throwCCE();
    coverLink.value = this.cover;
    var publisherField = Kotlin.isType(tmp$_2 = document.getElementById('publisher'), HTMLInputElement) ? tmp$_2 : throwCCE();
    publisherField.value = this.publisher;
    var overviewField = Kotlin.isType(tmp$_3 = document.getElementById('overview'), HTMLInputElement) ? tmp$_3 : throwCCE();
    overviewField.value = this.overview;
    var yearField = Kotlin.isType(tmp$_4 = document.getElementById('released_at'), HTMLInputElement) ? tmp$_4 : throwCCE();
    yearField.value = this.release_year.toString();
  };
  Book.$metadata$ = {
    kind: Kind_CLASS,
    simpleName: 'Book',
    interfaces: []
  };
  Book.prototype.component1 = function () {
    return this.title;
  };
  Book.prototype.component2 = function () {
    return this.author;
  };
  Book.prototype.component3 = function () {
    return this.cover;
  };
  Book.prototype.component4 = function () {
    return this.publisher;
  };
  Book.prototype.component5 = function () {
    return this.overview;
  };
  Book.prototype.component6 = function () {
    return this.release_year;
  };
  Book.prototype.copy_ymfrns$ = function (title, author, cover, publisher, overview, release_year) {
    return new Book(title === void 0 ? this.title : title, author === void 0 ? this.author : author, cover === void 0 ? this.cover : cover, publisher === void 0 ? this.publisher : publisher, overview === void 0 ? this.overview : overview, release_year === void 0 ? this.release_year : release_year);
  };
  Book.prototype.toString = function () {
    return 'Book(title=' + Kotlin.toString(this.title) + (', author=' + Kotlin.toString(this.author)) + (', cover=' + Kotlin.toString(this.cover)) + (', publisher=' + Kotlin.toString(this.publisher)) + (', overview=' + Kotlin.toString(this.overview)) + (', release_year=' + Kotlin.toString(this.release_year)) + ')';
  };
  Book.prototype.hashCode = function () {
    var result = 0;
    result = result * 31 + Kotlin.hashCode(this.title) | 0;
    result = result * 31 + Kotlin.hashCode(this.author) | 0;
    result = result * 31 + Kotlin.hashCode(this.cover) | 0;
    result = result * 31 + Kotlin.hashCode(this.publisher) | 0;
    result = result * 31 + Kotlin.hashCode(this.overview) | 0;
    result = result * 31 + Kotlin.hashCode(this.release_year) | 0;
    return result;
  };
  Book.prototype.equals = function (other) {
    return this === other || (other !== null && (typeof other === 'object' && (Object.getPrototypeOf(this) === Object.getPrototypeOf(other) && (Kotlin.equals(this.title, other.title) && Kotlin.equals(this.author, other.author) && Kotlin.equals(this.cover, other.cover) && Kotlin.equals(this.publisher, other.publisher) && Kotlin.equals(this.overview, other.overview) && Kotlin.equals(this.release_year, other.release_year)))));
  };
  var trim = Kotlin.kotlin.text.trim_gw00vp$;
  function main$lambda$lambda(closure$button) {
    return function (it) {
      var tmp$;
      var isbn = Kotlin.isType(tmp$ = document.getElementById('isbn'), HTMLInputElement) ? tmp$ : throwCCE();
      closure$button.disabled = true;
      var $receiver = isbn.value;
      var tmp$_0;
      var value = trim(Kotlin.isCharSequence(tmp$_0 = $receiver) ? tmp$_0 : throwCCE()).toString();
      if (!equals(value, '') && (value.length === 10 || value.length === 13))
        getInfos(value);
      else {
        window.alert('Invalid ISBN');
        closure$button.disabled = false;
      }
      return Unit;
    };
  }
  function main$lambda(it) {
    var tmp$;
    var button = Kotlin.isType(tmp$ = document.getElementById('getinfo'), HTMLButtonElement) ? tmp$ : throwCCE();
    button.addEventListener('click', main$lambda$lambda(button));
    return Unit;
  }
  function main(args) {
    window.onload = main$lambda;
  }
  function createBook(data) {
    var tmp$, tmp$_0, tmp$_1, tmp$_2, tmp$_3;
    var releaseDate = toString(data['releaseDate']);
    var year = substringBefore(releaseDate, '-');
    return new Book(typeof (tmp$ = data['title']) === 'string' ? tmp$ : throwCCE(), typeof (tmp$_0 = data['author']) === 'string' ? tmp$_0 : throwCCE(), typeof (tmp$_1 = data['linkImage']) === 'string' ? tmp$_1 : throwCCE(), typeof (tmp$_2 = data['publisher']) === 'string' ? tmp$_2 : throwCCE(), typeof (tmp$_3 = data['overview']) === 'string' ? tmp$_3 : throwCCE(), toInt(year));
  }
  function getInfos$lambda(closure$req, closure$button) {
    return function () {
      if (closure$req.v.readyState == 4 && closure$req.v.status == 200) {
        try {
          var json_data = JSON.parse(closure$req.v.responseText);
          var data = json_data[0];
          console.log(data);
          var book = createBook(data);
          book.updateView();
          closure$button.disabled = false;
        }
         catch (e) {
          console.log(e);
          closure$button.disabled = false;
        }
      }
    };
  }
  function getInfos(isbn) {
    var tmp$;
    var req = {v: new XMLHttpRequest()};
    var button = Kotlin.isType(tmp$ = document.getElementById('getinfo'), HTMLButtonElement) ? tmp$ : throwCCE();
    var home = window.location.hostname;
    if (equals(home, '127.0.0.1'))
      home = 'http://' + home + ':3000';
    req.v.onreadystatechange = getInfos$lambda(req, button);
    console.log('Book request @: ' + home + '/book_api/?isbn=' + isbn + '&max_result=1');
    req.v.open('GET', home + '/book_api/?isbn=' + isbn + '&max_result=1', true);
    req.v.send();
  }
  _.Book = Book;
  _.main_kand9s$ = main;
  _.createBook_qk3xy8$ = createBook;
  _.getInfos_61zpoe$ = getInfos;
  main([]);
  Kotlin.defineModule('bookinfo_kotlin', _);
  return _;
}(typeof bookinfo_kotlin === 'undefined' ? {} : bookinfo_kotlin, kotlin);
