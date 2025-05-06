board = Board.create!(name: "Kanban Board")

[ 'To Do', 'In Progress', 'Review', 'Done', 'Archived' ].each_with_index do |column_name, index|
  column = board.board_columns.create!(name: column_name)

  rand(1..3).times do |j|
    column.cards.create!(title: "Card #{j + 1}", description: "Description for card #{j + 1} in #{column_name}")
  end
end

board = Board.create!(name: "Visuality Workshops")

col = board.board_columns.create!(name: 'Before')
col.cards.create!(title: 'Workshop Checklist', description: "computer + Internet connection + ruby 3.3.0 + Git + Redis")
col.cards.create!(title: 'Log in to Discord channel', description: 'link was provided in email')

col = board.board_columns.create!(name: 'Turbo Drive')
col.cards.create!(title: 'Inspect Network tab', description: "Check out requests in web pages and in workshop app")

col = board.board_columns.create!(name: 'Turbo Frames')
col.cards.create!(title: 'Edit Cards', description: "Add turbo frames to make edit-in-place for cards")
col.cards.create!(title: 'Edit Boards', description: "Add turbo frames to make edit-in-place for boards")
col.cards.create!(title: 'Edit Board Columns', description: "..and the same for board columns")
col.cards.create!(title: 'Fix some links!', description: "use _top frame to target the whole html body")

col = board.board_columns.create!(name: 'Turbo Streams')
col.cards.create!(title: 'Add Cards', description: "Use turbo streams to create new cards")
col.cards.create!(title: 'Add Boards', description: "Use turbo streams to create new boards")
col.cards.create!(title: 'Add Board Columns', description: "..and the same for board columns")

col = board.board_columns.create!(name: 'Hotwire Broadcasts')
col.cards.create!(title: 'Make it live!', description: "Refresh columns with broadcasting")

col = board.board_columns.create!(name: 'Extras (Homework)')
col.cards.create!(title: 'Ups! What about JS?', description: "Disable JS in browser and check if the app still works")
col.cards.create!(title: 'Really ambitious?', description: "Go through Hotrails.dev tutorial")

col = board.board_columns.create!(name: 'After')
col.cards.create!(title: 'Fill in the Questionnaire', description: "we wait for your feedback")
col.cards.create!(title: 'Let the world know!', description: "If you enjoyed the workshop, why not tweet about it? ;)")
col.cards.create!(title: 'Connect!', description: "Find us on Twitter, @mlecicki, @ppwitek or on LinkedIn")

puts 'Seed data created successfully!'
puts 'Have fun at our workshops!'
