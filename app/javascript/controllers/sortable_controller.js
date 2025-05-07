import { Controller } from "@hotwired/stimulus"
import { put } from "@rails/request.js"
import Sortable from "sortablejs"

export default class extends Controller {
  static values = {
    url: String,
    group: String
  };

  static targets = ["cardsContainer"];

  constructor(...args) {
    super(...args);
    this.sortables = [];
  }

  connect() {
    this.initializeSortable();
  }

  disconnect() {
    this.destroySortable();
  }

  initializeSortable() {
    this.cardsContainerTargets.forEach(container => {
      const existingSortable = this.sortables.find(sortable => sortable.el === container);
      if (!existingSortable) {
        const sortable = Sortable.create(container, {
          group: this.groupValue,
          onEnd: this.onEnd.bind(this),
          animation: 150
        });
        this.sortables.push(sortable);
      }
    });
  }

  destroySortable() {
    if (this.sortables) {
      this.sortables.forEach(sortable => sortable.destroy());
      this.sortables = [];
    }
  }

  cardsContainerTargetConnected() {
    this.initializeSortable();
  }

  cardsContainerTargetDisconnected() {
    this.initializeSortable();
  }

  onEnd(event) {
    const { newIndex, item, to } = event;
    const id = item.dataset.sortableId;
    const newColumnId = to.closest('.board-column').dataset.sortableColumnIdValue;
    const url = this.urlValue.replace(":id", id);

    const card = {
      position: newIndex + 1,
      board_column_id: newColumnId,
    };

    const body = {
      card: card,
    };

    put(url, {
      body: JSON.stringify(body),
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector("[name='csrf-token']").content
      }
    });
  }
}
