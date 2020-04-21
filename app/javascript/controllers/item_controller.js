// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"
import axios from "axios"
import Rails from "@rails/ujs"

export default class extends Controller {
  // static targets = [ "output" ]
  static targets = [ "icon" ]//選到html el 

  initialize(){
    this.clicked = false;
  }

  heart(e){
    e.preventDefault()
    console.log('Heart is clicked!')
    if (this.clicked){
      this.iconTarget.classList.remove('fas');
      this.iconTarget.classList.add('far');
      this.clicked = false;
    } else {
      this.iconTarget.classList.remove('far');
      this.iconTarget.classList.add('fas');
      this.clicked = true;
    }

    let item_id = document.querySelector('#item_id').value

    // const csrfToken = document.querySelector('[name=csrf-token]').content
    // axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken

    //Rails.ajax
    Rails.ajax({
      url: `/api/v1/items/${item_id}/favorite`,
      type: 'POST',
      success: resp => {
        console.log(resp);
        if (resp.status === "favorited"){
          // console.log('yes')
          this.iconTarget.classList.remove('far');
          this.iconTarget.classList.add('fas');
        } else {
          // console.log('no')
          this.iconTarget.classList.remove('fas');
          this.iconTarget.classList.add('far');
        }
      },
      error: err => {
        console.log(err);
      }
    })


    // axios.post(`/api/v1/items/${item_id}/favorite`)
    // .then(resp => {
    //   if (resp.data.status === "favorited"){
    //     // console.log('yes')
    //     this.iconTarget.classList.remove('far');
    //     this.iconTarget.classList.add('fas');
    //   } else {
    //     // console.log('no')

    //     this.iconTarget.classList.remove('fas');
    //     this.iconTarget.classList.add('far');
    //   }
    //   // console.log(resp.data);
    // })
    // .catch(function(err){
    //   console.log(err);
    // })
    }


  connect() {
    // this.outputTarget.textContent = 'Hello, Stimulus!'
    console.log('HI123')
  }
}
