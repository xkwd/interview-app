namespace :utils do
  desc "Replace a link stored in interview answers contents"
  task :rename_link, [:old_link, :new_link] => :environment do |_, args|
    answers = Answer.where("content ILIKE ?", "%#{args[:old_link]}%")
    if answers.count > 0
      p "Replacing old link '#{args[:old_link]}' with a new link"\
        " '#{args[:new_link]}' in #{answers.count} answers..."
      answers.each do |answer|
        new_content = answer.content.gsub!(/#{args[:old_link]}/i, args[:new_link])
        answer.update_attributes(content: new_content)
      end
    else
      p "No old links found to replace."
    end
  end
end
