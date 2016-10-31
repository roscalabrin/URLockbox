$(document).ready( () => {
  new Links()
})

class Links {
  constructor() {
    this.updateReadStatusListener()
    this.searchListener()
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
      this.filterLinks()
    })
  }
  
  filterLinks() {
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
      console.log('hi')
      if (data.read) {
          $(`#link-container-${data.id}`).children()[2].innerHTML = 'Mark as Unread'
          
      } else {
          $(`#link-container-${data.id}`).children()[2].innerHTML = 'Mark as Read'
      }    
    }
  }
}