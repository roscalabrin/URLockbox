$(document).ready( () => {
  new Links()
})

class Links {
  constructor() {
    this.updateReadStatusListenerOne()
    this.updateReadStatusListenerTwo()
  }
  
  updateReadStatusListenerOne() {
    $('#parent').on('click', '.btn-read-false', (e) => {
      const linkId = e.target.parentNode.dataset.id
      const newStatus = "true"
      this.updateReadStatus(linkId, newStatus)
      this.updateReadStatusListenerTwo()
    })
  }
  
  updateReadStatusListenerTwo() {
    $('#parent').on('click', '.btn-read-true', (e) => {
      const linkId = e.target.parentNode.dataset.id
      const newStatus = "false"
      const button = e.target
      this.updateReadStatus(linkId, newStatus)
      this.updateReadStatusListenerOne()
    })
  }
  
  updateReadStatus(linkId, newStatus) {
    $.ajax({
      type: "PUT",
      url: `api/v1/links/${linkId}`,
      data: {status: newStatus},
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