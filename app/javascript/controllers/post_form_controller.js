// app/javascript/controllers/post_form_controller.js
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="post-form"
export default class extends Controller {
  static targets = ["recruitFields", "statusSelect"]

  connect() {
    this.toggleRecruitFields()
  }

  toggleRecruitFields() {
    const status = this.statusSelectTarget.value
    const isRecruiting = status === "recruiting"
    this.recruitFieldsTarget.classList.toggle("hidden", !isRecruiting)
  }
}
