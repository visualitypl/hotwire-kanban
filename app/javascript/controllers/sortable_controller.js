import { Controller } from "@hotwired/stimulus"
import { put } from "@rails/request.js"
import Sortable from "sortablejs"

export default class extends Controller {
  static values = {
    url: String,
    group: String
  };

  static targets = ["cardsContainer"];

  connect() {
    // Initialize Sortable on all card containers using targets
    this.sortables = this.cardsContainerTargets.map(container => {
      return Sortable.create(container, {
        group: this.groupValue,
        onEnd: this.onEnd.bind(this),
        animation: 150
      });
    });
  }

  disconnect() {
    // Destroy all sortables
    this.sortables.forEach(sortable => sortable.destroy());
  }

  onEnd(event) {
    const { newIndex, item, to } = event;
    const id = item.dataset.sortableId;
    const newColumnId = to.closest('.board-column').dataset.sortableColumnIdValue;
    const url = this.urlValue.replace(":id", id);

    put(url, {
      body: JSON.stringify({ position: newIndex, column_id: newColumnId }),
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector("[name='csrf-token']").content
      }
    });
  }
}
