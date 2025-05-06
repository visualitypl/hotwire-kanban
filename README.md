# README

A simple application to experiment with Turbo.

## Setup

This application uses:
- ruby 3.3.0
- sqlite 3
- redis

Have them installed, clone repo and run:

```
$ bundle
$ rails db:setup
```

You can run `rails db:seed` many times to have more data.

Use `rails s` to run the server.

## Testing

Run `$ rspec` for tests.

Run `$ rubocop` for linter check.

# Knowledge base

## Turbo Drive

Links: \
https://hotwired.dev/ \
https://turbo.hotwired.dev/handbook/drive

### Task 1

- go to any web page
- analyse content of Network tab in Inspector during navigating through sub-pages
- run workshop app with `rails s`
- analyse content of Network tab in Inspector during navigating through sub-pages
- add at the bottom of `app/javascript/application.js`
```
Turbo.session.drive = false
```

- analyse content of Network tab in Inspector during navigating through sub-pages

## Turbo Frames

Links: \
https://turbo.hotwired.dev/handbook/frames \
https://rubydoc.info/github/hotwired/turbo-rails/Turbo%2FFramesHelper:turbo_frame_tag \
https://apidock.com/rails/ActionView/RecordIdentifier/dom_id

### Task 1: edit in place for cards
Add turbo frames for cards to enable edit in place

1. Update `app/views/cards/_card.html.erb` -
    wrap all the code into turbo frame tag block:
    <details>
    <summary>Updated file:</summary>

    ```erb
    <%= turbo_frame_tag dom_id(card) do %>
        <div class="card card-body">
            <div class="d-flex justify-content-between align-items-center mb-2">
            <h5 class="card-title mb-0">
                <%= card.title %>
            </h5>
            <div class="d-flex gap-2">
                <%= link_to edit_card_path(card), class: 'text-default' do %>
                <i class="fa-solid fa-pencil"></i>
                <% end %>
                <%= link_to card_path(card), data: { turbo_method: :delete, turbo_confirm: 'Are you sure?' }, class: 'text-danger' do %>
                <i class="fa-solid fa-trash"></i>
                <% end %>
            </div>
            </div>
            <div class="card-text text-primary-grey-600">
                <%= card.description %>
            </div>
        </div>
    <% end %>
    ```
</details>


2. Update `app/views/cards/edit.html.erb` - wrap ‘form’ into turbo frame tag block:
   <details>
    <summary>Updated file:</summary>

    ```erb
    <h1 class="text-primary-dark-500">Edit Card</h1>

    <div class="row w-100 justify-content-center mt-3">
        <%= turbo_frame_tag dom_id(@card) do %>
        <div class="border border-primary-grey-200 bg-light p-2">
            <%= render 'form' %>
        </div>
        <% end %>
    </div>
    ```
</details>


### Task 2: edit in place for board columns
Add turbo frames to board column headers to edit column names in place

1. Update `app/views/board_columns/_column_header.html.erb` -
    wrap all the code into turbo frame tag block:
    <details>
    <summary>Updated file:</summary>

    ```erb
    <%= turbo_frame_tag dom_id(board_column, :edit) do %>
    <div class="d-flex flex-row">
        <h5 class="d-flex flex-col">
        <%= board_column.name %>
        </h5>
        <div class="d-flex flex-col ms-auto gap-2">
            <%= link_to edit_board_column_path(board_column) do %>
            <div class="fa-solid fa-pencil text-primary-dark-600"></div>
            <% end %>
            <%= link_to board_column_path(board_column), data: { turbo_method: :delete, turbo_confirm: 'Are you sure?' } do %>
            <div class="fa-solid fa-trash text-primary-dark-600"></div>
            <% end %>
        </div>
    </div>
    <% end %>
    ```
</details>


2. Update `app/views/board_columns/edit.html.erb` - wrap ‘form’ into turbo frame tag block:
   <details>
    <summary>Updated file:</summary>

    ```erb
    <h1 class="text-primary-dark-500">Edit Board Column</h1>

    <div class="row w-100 justify-content-center mt-3">
    <%= turbo_frame_tag dom_id(@board_column, :edit) do %>
        <div class="border border-primary-grey-200 bg-light p-2">
        <%= render 'form' %>
        </div>
    <% end %>
    </div>
    ```
</details>

### Task 3: edit in place for boards
Add turbo frames to board headers to edit board name in place

1. Update `app/views/boards/index.html.erb` -
    wrap .card-header into turbo frame tag block (line 17):
    <details>
    <summary>Updated file:</summary>

    ```erb
    <div class="row w-100">
    <div class="d-flex justify-content-between">
        <%= link_to 'New Board', new_board_path, class: 'btn btn-outline-primary invisible' %>
        <h1 class="text-primary-dark-500">
        Boards
        </h1>
        <div>
        <%= link_to 'New Board', new_board_path, class: 'btn btn-outline-primary' %>
        </div>
    </div>
    </div>

    <div class="row w-100">
    <% @boards.each do |board| %>
        <div class="col-3 my-3">
        <div class="card border border-primary-grey-200">
            <%= turbo_frame_tag dom_id(board, :edit) do %>
            <div class="card-header bg-primary-grey-200">
                <div class="d-flex justify-content-between align-items-center">
                <h5 class="card-title mb-0">
                    <%= link_to board.name, board, class: 'link-underline link-underline-opacity-0' %>
                </h5>
                <div class="d-flex gap-2">
                    <%= link_to edit_board_path(board), class: 'text-default' do %>
                    <i class="fa-solid fa-pencil text-primary-dark-600"></i>
                    <% end %>
                    <%= link_to board, data: { turbo_method: :delete, turbo_confirm: 'Are you sure?' }, class: 'text-danger' do %>
                    <i class="fa-solid fa-trash text-primary-dark-600"></i>
                    <% end %>
                </div>
                </div>
            </div>
            <% end %>
            <div class="card-body bg-primary-grey-100">
            <div class="card-text">
                <p>
                <%= "Columns: #{board.board_columns.size}" %>
                </p>
                <p>
                <%= "Cards: #{board.board_columns.joins(:cards).count}" %>
                </p>
            </div>
            </div>
        </div>
        </div>
    <% end %>
    </div>
    ```
</details>


2. Update `app/views/boards/edit.html.erb` - wrap ‘form’ into turbo frame tag block:
   <details>
    <summary>Updated file:</summary>

    ```erb
    <h1 class="text-primary-dark-500">Edit Board</h1>

    <div class="row w-100 justify-content-center mt-3">
    <%= turbo_frame_tag dom_id(@board, :edit) do %>
        <div class="border border-primary-grey-200 bg-light p-2">
        <%= render 'form' %>
        </div>
    <% end %>
    </div>
    ```
</details>


**Branch with all edits-in-place:** `git checkout turbo-frames-edits`

### Task 4: Fix show board link

1. Update `app/views/boards/index.html.erb` - add `data: { turbo_frame: '_top' }` to show link:
   <details>
    <summary>Updated file:</summary>

    ```erb
    <h5 class="card-title mb-0">
        <%= link_to board.name, board, data: { turbo_frame: '_top'}, class: 'link-underline link-underline-opacity-0' %>
    </h5>
    ```
</details>

**Branch with fixed link:** `git checkout turbo-frames-top`


## Turbo Streams

Links: \
https://turbo.hotwired.dev/handbook/streams

### Task 1: Fix deleting cards

1. Update `app/controllers/cards_controller.rb#destroy` -
    add turbo stream format response
    <details>
    <summary>Updated file:</summary>

    ```rb
    respond_to do |format|
      format.html { redirect_to board_url(board), notice: "Card was successfully destroyed." }
      format.turbo_stream
    end
    ```
</details>


2. Create `app/views/cards/destroy.turbo_stream.erb`
   <details>
    <summary>Updated file:</summary>

    ```erb
    <%= turbo_stream.remove dom_id(@card) %>
    ```
</details>


### Task 2: Fix deleting board columns

1. Update `app/controllers/board_columns_controller.rb#destroy` -
    add turbo stream format response with inline turbo stream render
    <details>
    <summary>Updated file:</summary>

    ```rb
    respond_to do |format|
      format.html { redirect_to board_url(board), notice: "BoardColumn was successfully destroyed." }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@board_column) }
    end
    ```
</details>


2. Update `app/views/board_columns/_board_column.html.erb` - add unique ID for
   board columns:
   <details>
    <summary>Updated file:</summary>

    ```erb
    <div id= <%= dom_id(board_column)%> class="board-column" data-sortable-column-id-value="<%= board_column.id %>">
    <%= render partial: 'board_columns/column_header', locals: { board_column: board_column } %>

    <div id= <%= dom_id(board_column, :column_body) %>, class="board-column-body", data-sortable-target="cardsContainer">
        <% board_column.cards.order(:position).each do |card| %>
        <div class="draggable_card my-1" data-sortable-id="<%= card.id %>">
            <%= render partial: 'cards/card', locals: { card: card } %>
        </div>
        <% end %>
    </div>

    <div class="board-column-footer">
        <%= link_to new_card_url(board_column_id: board_column.id), class: 'text-success fs-2' do %>
        <div class="fa-solid fa-plus"></div>
        <% end %>
    </div>
    </div>
    ```
</details>

### Task 3: Fix deleting boards

1. Update `app/controllers/boards_controller.rb#destroy` -
    add turbo stream format response with inline turbo stream render
    <details>
    <summary>Updated file:</summary>

    ```rb
    def destroy
        @board.destroy!

        respond_to do |format|
        format.html { redirect_to boards_url, notice: "Board was successfully destroyed." }
        format.turbo_stream { render turbo_stream: turbo_stream.remove(@board) }
        end
    end
    ```
</details>


2. Update `app/views/boards/index.html.erb` - add unique IDs for each board:
   <details>
    <summary>Updated file:</summary>

    ```erb
    <div class="row w-100">
    <div class="d-flex justify-content-between">
        <%= link_to 'New Board', new_board_path, class: 'btn btn-outline-primary invisible' %>
        <h1 class="text-primary-dark-500">
        Boards
        </h1>
        <div>
        <%= link_to 'New Board', new_board_path, class: 'btn btn-outline-primary' %>
        </div>
    </div>
    </div>

    <div class="row w-100">
    <% @boards.each do |board| %>
        <div id= <%= dom_id(board) %> class="col-3 my-3">
        <div class="card border border-primary-grey-200">
            <%= turbo_frame_tag dom_id(board, :edit) do %>
            <div class="card-header bg-primary-grey-200">
                <div class="d-flex justify-content-between align-items-center">
                <h5 class="card-title mb-0">
                    <%= link_to board.name, board, data: { turbo_frame: '_top'}, class: 'link-underline link-underline-opacity-0' %>
                </h5>
                <div class="d-flex gap-2">
                    <%= link_to edit_board_path(board), class: 'text-default' do %>
                    <i class="fa-solid fa-pencil text-primary-dark-600"></i>
                    <% end %>
                    <%= link_to board, data: { turbo_method: :delete, turbo_confirm: 'Are you sure?' }, class: 'text-danger' do %>
                    <i class="fa-solid fa-trash text-primary-dark-600"></i>
                    <% end %>
                </div>
                </div>
            </div>
            <% end %>
            <div class="card-body bg-primary-grey-100">
            <div class="card-text">
                <p>
                <%= "Columns: #{board.board_columns.size}" %>
                </p>
                <p>
                <%= "Cards: #{board.board_columns.joins(:cards).count}" %>
                </p>
            </div>
            </div>
        </div>
        </div>
    <% end %>
    </div>
    ```
</details>


**Branch with all deletes fixed:** `git checkout turbo-frames-deletes`

### Task 4: Create new Cards with Turbo Streams

1. Extract 'New Card link' into partial - create `app/views/cards/_new_card.html.erb`:
   <details>
    <summary>Created file:</summary>

    ```erb
    <%= link_to new_card_url(board_column_id: board_column.id), class: 'text-success fs-2' do %>
        <div class="fa-solid fa-plus"></div>
    <% end %>
    ```
</details>

2. Use new partial in `app/views/board_columns/_board_column.html.erb`:
    <details>
    <summary>Updated file:</summary>

    ```erb
    <div class="board-column-footer">
        <%= render partial: 'cards/new_card', locals: { board_column: board_column } %>
    </div>
    ```
</details>

3. Render new card form in place: wrap link to New Card into turbo frame in `app/views/cards/_new_card.html.erb`:
    <details>
    <summary>Updated file:</summary>

    ```erb
    <%= turbo_frame_tag dom_id(board_column, :new_card) do %>
        <%= link_to new_card_url(board_column_id: board_column.id), class: 'text-success fs-2' do %>
            <div class="fa-solid fa-plus"></div>
        <% end %>
    <% end %>
    ```
</details>

4. Wrap 'form' into turbo frame in `app/views/cards/new.html.erb`:
    <details>
    <summary>Updated file:</summary>

    ```erb
    <h1 class="text-primary-dark-500">New Card</h1>

    <div class="row w-100 justify-content-center mt-3">
        <%= turbo_frame_tag dom_id(@card.board_column, :new_card) do %>
            <div class="border border-primary-grey-200 bg-light p-2">
                <%= render 'form' %>
            </div>
        <% end %>
    </div>
    ```
</details>

5. Create turbo_stream response - update `app/controllers/cards_controller.rb#create` -
    <details>
    <summary>Updated file:</summary>

    ```rb
    respond_to do |format|
      if service.call
        @card = service.card
        format.html { redirect_to board_url(@card.board), notice: "Card was successfully created." }
        format.turbo_stream
      else
        @card = service.card
        format.html { render :new, status: :unprocessable_entity }
      end
    end
    ```
</details>

6. Create `app/views/cards/create.turbo_stream.erb`:
    <details>
    <summary>Created file:</summary>

    ```erb
    <%= turbo_stream.append dom_id(@card.board_column, :column_body) do %>
        <%= render 'cards/card', card: @card %>
    <% end %>
    <%= turbo_stream.replace dom_id(@card.board_column, :new_card) do %>
        <%= render 'cards/new_card', board_column: @card.board_column %>
    <% end %>
    ```
</details>


### Task 5: Create new Boards with Turbo Streams

Add create-in-place for boards.
    <details>
    <summary>Updated files</summary>

    No solution here.
    Try to implement it on your own. You can do it! 💪
    Or, checkout to branch with solution.
</details>


### Task 6: Create new Board Columns with Turbo Streams

Add create-in-place for board columns. Ideally, new columns should be added
right to existing ones.
    <details>
    <summary>Updated files</summary>

    No solution here.
    Try to implement it on your own. You can do it! 💪
    Or, checkout to branch with solution.
</details>


**Branch with all records creation:** `git checkout turbo-frames-creates`


## Turbo Broadcasts

Links: \
https://www.rubydoc.info/gems/turbo-rails/Turbo/Broadcastable \
https://www.hotrails.dev/turbo-rails/turbo-streams

### Task 1: Adding broadcasts to columns

1. Update `app/views/boards/show.html.erb` -
   Add turbo stream tag to connect user to websocket channel at the top of file
 <details>
    <summary>New line:</summary>

   ```erb
      <%= turbo_stream_from dom_id(@board) %>
   ```
</details>

also within the same file add turbo stream tag that we will use to append broadcasted columns
<details>
   <summary>New line in file placement:</summary>

   ```erb
      <% @board_columns.each do |board_column| %>
         <%= render partial: 'board_columns/board_column', locals: { board_column: board_column } %>
      <% end %>
      <%= turbo_frame_tag dom_id(@board, 'columns') # newly added line %>
      <%= turbo_frame_tag dom_id(BoardColumn.new) %>
   ```
</details>

2. Update `app/models/board_column.rb` -
   include ActionView::RecordIdentifier library to use `dom_id` in model,
   add broadcast callback to model

<details>
   <summary>Updated file:</summary>

   ```rb
   class BoardColumn < ApplicationRecord
   include ActionView::RecordIdentifier

   # ... leave old code

   broadcasts_to ->(board_column) { "board_#{board_column.board_id}" },
             target: ->(board_column) { "columns_board_#{board_column.board.id}" },
             inserts_by: :append
   ```
</details>


### Task 2: Triggering columns broadcasts on card changes

1. Update `app/models/card.rb` -
   add callback that will touch and update associated columns while modifying cards

<details>
    <summary>Updated file:</summary>

   ```rb
   class Card < ApplicationRecord
      include ActionView::RecordIdentifier

      # ... leave old code

      after_commit :touch_affected_board_columns

      private

      def touch_affected_board_columns
         if previous_changes[:board_column_id].present?
            board.board_columns.find_by(id: previous_changes[:board_column_id]&.first)&.touch
            board.board_columns.find_by(id: previous_changes[:board_column_id]&.last)&.touch
         else
            board_column.touch
         end
      end
   end
   ```
</details>

**Branch with broadcasts:** `git checkout turbo-broadcasts`
