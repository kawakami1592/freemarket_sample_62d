crumb :root do
  link "トップページ", root_path
end
crumb :hoge do
  @item = Item.find_by(id:params[:id])
  link @item.name, item_path
  parent :category3
end
crumb :category1 do 
  @item = Item.find_by(id:params[:id])
  link @item.category.parent.parent.name,link_to = '#'
end
crumb :category2 do
  @item = Item.find_by(id:params[:id])
  link @item.category.name,link_to = '#'
  parent :category1
end
crumb :category3 do
  @item = Item.find_by(id:params[:id])
  link @item.category.parent.name,link_to = '#'
  parent :category2
end
crumb :buy do 
  link "購入確認", buy_item_path
  parent :hoge
end
crumb :mypage do
  link "マイページ", edit_user_path(current_user.id)
end
crumb :logout do 
  link "ログアウト", logout_user_path
  parent :mypage
end
crumb :card do 
  link "クレジット登録"
  parent :mypage
end
crumb :nocard do 
  link "クレジット変更(削除)"
  parent :mypage
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).