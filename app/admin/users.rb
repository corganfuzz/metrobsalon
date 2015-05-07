ActiveAdmin.register User, :as => "Customer" do
  permit_params :username, :created_at, :updated_at, :password_hash, :password_salt, :email, :phone
  menu :priority => 3
  config.batch_actions = true

  filter :username
  filter :email
  filter :created_at
  filter :phone

  form do |f|
    f.inputs do
      f.input :username
      # f.input :user
      f.input :email
      f.input :phone
    end
    f.actions
end
  index :title => "Shear Edge" do
    selectable_column
    id_column
    column("Customer", :username)
    column :email
    column("Registered on", :created_at)
    column :phone
    actions
  end

  show :title => :username do
    panel "Order History" do
      table_for(customer.orders) do
        column("Order", :sortable => :id) {|order| link_to "##{order.id}", admin_order_path(order) }
        column("State")                   {|order| status_tag(order.state) }
        column("Date", :sortable => :checked_out_at){|order| pretty_format(order.checked_out_at) }
        column("Total")                   {|order| number_to_currency order.total_price }
      end
    end
  end

  sidebar "Customer Details", :only => :show do
    attributes_table_for customer, :username, :email, :phone, :created_at
  end

  sidebar "Order History", :only => :show do
    attributes_table_for customer do
      row("Total Orders") { customer.orders.complete.count }
      row("Total Value") { number_to_currency customer.orders.complete.sum(:total_price) }
    end
  end

 # sidebar "Active Admin Demo" do
   # render('/admin/sidebar_links', :model => 'users')
  #end
end
