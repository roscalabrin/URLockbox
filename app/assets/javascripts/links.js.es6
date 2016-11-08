$(document).ready( () => {
  new Links()
})

class Links {
  constructor() {
    this.updateReadStatusListener()
    this.searchListener()
    this.filterListener()
    this.sortAlphabeticallyListener()
  }
  
  sortAlphabeticallyListener() {
    $('#sort-alphabetically').on('click', () => {
      const $divs = $("div.link-details")
      const alphabeticallyOrderedDivs = $divs.sort(function (a, b) {
        $(a).find("h4").text() > $(b).find("h4").text();
      })
      $(".all-links").html(alphabeticallyOrderedDivs);
    })
  }
   
  updateReadStatusListener() {
    $('#parent').on('click', '.btn-read', (e) => {
      const linkId = e.target.parentNode.dataset.id
      this.updateReadStatus(linkId)
    })
  }
  
  searchListener() {
    $('#parent').on('keyup', '.search-links', (e) => {
      const criteria = $('.search-links').val()
      this.matchSearch()
    })
  }
  
  filterListener() {
    $('#parent').on('click', '.radio-inline', (e) => {
      const filter = e.target.innerText
      if (filter === "Show Read") {
        this.filterRead()
      } else if (filter === "Show Unread") {
        this.filterUnread()
      } else if (filter === "Show All") {
        this.showAll()
      }
    })
  }
  
  filterRead() {
    const linksDiv = Array.from(document.getElementsByClassName('link-details'))
    linksDiv.map(function(link) {
      $(link).closest('.link-details').removeClass("hide")
      if ($(link).find('.btn-read').text() === "Mark as Read") {
        $(link).closest('.link-details').addClass("hide")
      } 
    })
  }
  
  filterUnread() {
    const linksDiv = Array.from(document.getElementsByClassName('link-details'))
    linksDiv.map(function(link) {
      $(link).closest('.link-details').removeClass("hide")
      if ($(link).find('.btn-read').text() === "Mark as Unread") {
        $(link).closest('.link-details').addClass("hide")
      } 
    })
  }
  
  showAll() {
    const linksDiv = Array.from(document.getElementsByClassName('link-details'))
    linksDiv.map(function(link) {
      $(link).closest('.link-details').removeClass("hide")
    })
  }
  
  matchSearch() {
    const titlesDiv = Array.from(document.getElementsByClassName('link-details'))
    titlesDiv.map(function(link) {
      const criteria = $('.search-links').val().toLowerCase()
      if ($(link).text().toLowerCase().trim().includes(criteria)) {
        $(link).closest('.link-details').removeClass("hide")
      } else {
        $(link).closest('.link-details').removeClass("hide")
        $(link).closest('.link-details').addClass("hide")
      }
    })
  }    
  
  updateReadStatus(linkId) {
    $.ajax({
      type: "PUT",
      url: `api/v1/links/${linkId}`,
      success: response => success(response)
    })
    function success(data) {
      var text = document.getElementById(`link-container-${data.id}`).getElementsByTagName('h4')[0]
      var link = document.getElementById(`link-container-${data.id}`).getElementsByTagName('p')[0]
      if (data.read) {
        document.getElementById(`link-container-${data.id}`).getElementsByTagName('button')[0].innerHTML = 'Mark as Unread'
        text.className = 'orange'
        link.className = 'orange'
      } else {
        document.getElementById(`link-container-${data.id}`).getElementsByTagName('button')[0].innerHTML = 'Mark as Read'
        text.className = 'black'
        link.className = 'black'
      }    
    }
  }
}