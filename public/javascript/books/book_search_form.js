function initializeBookStorage() {
	if (typeof (localStorage.books) == "undefined") {
		localStorage.books = "[]";
	}
	if (localStorage.books != "[]") printBookStorage();
	addEventHandlers();
}

function addBookStorage() {
	var title = document.getElementById("title").value.trim();
	var author = document.getElementById("author").value.trim();
	var isbn = document.getElementById("isbn").value.trim();
	var year = document.getElementById("released_at").value.trim();
	if (title == "" && author == "" && isbn == "" && year == "") {
		alert("Title, Author, Year of release and ISBN can't be left blank");
		return false;
	}
	if ((title == "" || author == "") && isbn != "") {
		if (isNaN(isbn)) {
			alert("ISBN must be a number");
			return false;
		}
	} else if ((title == "" && author == "" && isbn != "") || ((title != "" || author != "") && isbn != "")) {
		if (isNaN(isbn)) {
			alert("ISBN must be a number");
			return false;
		}
		if (isbn.length != 13 && isbn.length !=10) {
			alert("ISBN must be 10 or 13 digits long");
			return false;
		}
	}

	if (author == "") author = "--";
	if (title == "") title = "--";
	if (isbn == "") isbn = "--"
    if (year == "") year = "--"
	var currentdate = new Date();
	var datetime = currentdate.getDate() + "/" +
		(currentdate.getMonth() + 1) + "/" +
		currentdate.getFullYear() + " @ " +
		currentdate.getHours() + ":" +
		currentdate.getMinutes() + ":" +
		currentdate.getSeconds();

	var u = JSON.parse(localStorage.books);
	var o = {
		title: title,
		author: author,
		isbn: isbn,
		date: datetime,
		year: year
	};
	u.unshift(o);
	var len=u.length;
	while (len > 5) {
		u.pop();
		len--;
	}
	localStorage.books = JSON.stringify(u);
	return true;
}


function printBookStorage() {
	var u = JSON.parse(localStorage.books);
	var l = u.length;
	var s = String("<h3>Search history:</h3>");
	var i = 0;
	while (i < l) {
		s += "<div class='search'><strong>Title: </strong>" + "<span style='display:inline' class='title'>" + u[i].title + "</span>" +
			" <strong>Author: </strong>" + "<span style='display:inline' class='author'>" + u[i].author + "</span>" +
			" <strong>ISBN:  </strong>" + "<span class='isbn' style='display:inline'>" + u[i].isbn + "</span>" +
			"<br/><strong>Year:  </strong>" + "<span class='released_at' style='display:inline'>" + u[i].year + "</span>" +
			" <strong>Time:  </strong>" + "<span id='time' style='display:inline'>" + u[i].date + "</span>" + "</div>";
		i++;
	}
	document.getElementById("bookStorage").innerHTML = s;
	return true;
}

function addEventHandlers() {
	var searchElement = document.getElementsByClassName("search");
	for (var i = 0; i < searchElement.length; i++) {
		searchElement[i].addEventListener("click", compileForm);
	}

}


function compileForm() {

	if (this.querySelector(".title").innerHTML != "--") {
		document.getElementById("title").value = this.querySelector(".title").innerHTML;
	} else document.getElementById("title").value = "";

	if (this.querySelector(".isbn").innerHTML != "--") {
		document.getElementById("isbn").value = this.querySelector(".isbn").innerHTML;
	} else document.getElementById("isbn").value = "";

    if (this.querySelector(".author").innerHTML != "--") {
        document.getElementById("author").value = this.querySelector(".author").innerHTML;
    } else document.getElementById("author").value = "";

    if (this.querySelector(".released_at").innerHTML != "--") {
        document.getElementById("released_at").value = this.querySelector(".released_at").innerHTML;
    } else document.getElementById("released_at").value = "";

}