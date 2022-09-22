prawn_document do |pdf|
  pdf.font_families.update( "Helvetica" => { normal: Rails.root.join('app', 'assets/fonts', 'Roboto-Regular.ttf').to_s, bold: Rails.root.join('app', 'assets/fonts', 'Roboto-Bold.ttf').to_s, italic: Rails.root.join('app', 'assets/fonts', 'Roboto-Regular.ttf').to_s, bold_italic: Rails.root.join('app', 'assets/fonts', 'Roboto-Regular.ttf').to_s } )

  table_data = [["Meal type", "Calories", "Fats", "Proteins", "Carbohydrates", "Created"]]

  entries.each do |entry|
    table_data = table_data + [(["#{entry.meal_type}", "#{entry.calories} kcal", "#{entry.fats}g", "#{entry.proteins}g", "#{entry.carbohydrates}g", "#{time_ago_in_words(entry.created_at)} ago"])]
  end

  pdf.text "Entries from: #{entries.first.created_at.to_date}         User: #{current_user.email}\n\n", :align => :center

  pdf.table table_data, {:header => true, :position => :center} do |table|
    table.header=(["Meal type", "Calories", "Fats", "Proteins", "Carbohydrates", "Created"])     
    table.cells[0,0].font_style = :bold
    table.cells[entries.find_index(entries.order("calories DESC").first)+1, 1].style(:background_color => 'FF0000')
    table.cells[entries.find_index(entries.order("fats DESC").first)+1, 2].style(:background_color => 'FF0000')
    table.cells[entries.find_index(entries.order("proteins DESC").first)+1, 3].style(:background_color => 'FF0000')
    table.cells[entries.find_index(entries.order("carbohydrates DESC").first)+1, 4].style(:background_color => 'FF0000')
end
end