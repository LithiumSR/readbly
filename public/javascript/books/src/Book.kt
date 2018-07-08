import org.w3c.dom.*
import kotlin.browser.document

data class Book(val title: String, val author: String, val cover: String, val publisher: String, val overview: String, val release_year: Int) {

    fun updateView(){
        val titleField = document.getElementById("title") as HTMLInputElement
        titleField.value = title
        val authorField = document.getElementById("author") as HTMLInputElement
        authorField.value = author
        val coverLink = document.getElementById("coverlink") as HTMLInputElement
        coverLink.value = cover
        val publisherField = document.getElementById("publisher") as HTMLInputElement
        publisherField.value = publisher
        val overviewField = document.getElementById("overview") as HTMLInputElement
        overviewField.value = overview
        val yearField = document.getElementById("released_at") as HTMLInputElement
        yearField.value = release_year.toString();
    }
}