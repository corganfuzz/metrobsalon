ActiveAdmin.register Product, :as => "Service" do

  menu :priority => 2
  permit_params :title, :description, :author, :price, :featured, :available_on, :image_file_name, :genre, :created_at

  scope :all, :default => true
  scope :available do |products|
    products.where("available_on < ?", Date.today)
  end
  scope :drafts do |products|
    products.where("available_on > ?", Date.today)
  end
  scope :featured_services do |products|
    products.where(:featured => true)
  end


  filter :title
  filter :author, label: 'Stylist'
  filter :price
  

  index :as => :grid do |product|
    div do
      a :href => admin_service_path(product) do
        image_tag("products/" + product.image_file_name)
      end
    end
    a truncate(product.title), :href => admin_service_path(product)
    div 'by ' + product.author
  end

   show :title => :title

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :author, label: "Stylist"
      f.input :image_file_name
      f.input :price

    end
    f.submit "Create Service"

  end

  show do
    attributes_table :title, :description, :author, :image_file_name, :price, :created_at, :updated_at
    :content
  end

  sidebar :product_stats, :only => :show do
    attributes_table_for resource do
      row("Total Sold")  { Order.find_with_product(resource).count }
      row("Dollar Value"){ number_to_currency LineItem.where(:product_id => resource.id).sum(:price) }
    end
  end

  sidebar :recent_orders, :only => :show do
    Order.find_with_product(resource).limit(5).collect do |order|
      auto_link(order)
    end.join(content_tag("br")).html_safe
  end
  #sidebar "Active Admin Demo" do
   # render('/admin/sidebar_links', :model => 'products')
  #end


end
