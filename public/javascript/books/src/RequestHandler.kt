import org.w3c.dom.HTMLButtonElement
import org.w3c.dom.HTMLInputElement
import org.w3c.xhr.XMLHttpRequest
import kotlin.browser.document
import kotlin.browser.window
import kotlin.js.Json

fun main(args: Array<String>){
    window.onload = {
        val button = document.getElementById("getinfo") as HTMLButtonElement
        button.addEventListener("click", {
            val isbn = document.getElementById("isbn") as HTMLInputElement
            button.disabled=true
            val tmp = button.innerText
            button.innerText = "Searching..."
            val value = isbn.value.trim()
            if(value != "" && (value.length==10 || value.length==13))getInfos(value,tmp)
            else {
                window.alert("Invalid ISBN")
                button.disabled=false
                button.innerText=tmp;
            }
        })
    }
}

fun createBook(data: Json): Book {
    val releaseDate = data["releaseDate"].toString()
    val year = releaseDate.substringBefore("-")
    return Book(data["title"] as String, data["author"] as String, data["linkImage"] as String, data["publisher"] as String, data["overview"] as String, year.toInt())
}

fun getInfos(isbn: String, text_button: String){
    var req :dynamic = XMLHttpRequest()
    val button = document.getElementById("getinfo") as HTMLButtonElement
    var home = window.location.hostname
    if (home =="127.0.0.1") home = "http://" + home + ":3000"
    req.onreadystatechange = fun(){
        if(req.readyState == 4 && req.status == 200) {
            try {
                val json_data = JSON.parse<Array<Json>>(req.responseText)
                val data = json_data[0]
                console.log(data)
                val book = createBook(data)
                book.updateView()
                button.disabled=false;
                button.innerText=text_button;
            } catch (e: dynamic) {
                console.log(e)
                button.disabled=false;
                button.innerText=text_button;
            }
        }
    }
    console.log("Book request @: "+home+"/book_api/?isbn="+isbn+"&max_result=1")
    req.open("GET",home+"/book_api/?isbn="+isbn+"&max_result=1",true)

    req.send()
}