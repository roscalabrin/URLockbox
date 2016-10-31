$(document).ready( () => {
  new Links()
})

class Links {
  constructor() {
    this.updateReadStatusListener()
  }
  
  updateReadStatusListener() {
    $('#parent').on('click', '.btn-read', (e) => {
      const linkId = e.target.parentNode.dataset.id
      this.updateReadStatus(linkId)
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