ActiveAdmin.register Order do
  menu :priority => 3
  config.batch_actions = true


  filter :total_price
  filter :checked_out_at

  scope :all, :default => true
  scope :in_progress
  scope :complete

  index do
    column("Order", :sortable => :id) {|order| link_to "##{order.id} ", admin_order_path(order) }
    column("Status")                   {|order| status_tag(order.state) }
    column("Order Date", :checked_out_at)
    column("Customer", :user, :sortable => :user_id)
    column("Appointment", :appointment)
    column("Total")                   {|order| number_to_currency order.total_price }

    #column("Appointment Date")        {|order| order.appointment.appointmentdate }

    #column :appointment do |order|
     #link_to order.appointment.appointmentdate.strftime("%A -  %B %d, %Y - %I:%M %p"), admin_appointment_path(order.appointment)
    #  end

   # column :appointment do |order|
    #  if Appointment.nil?
    #    link_to('New Appointment', new_admin_appointment_path)
    #  else Appointment.present?
     #   link_to order.appointment.appointmentdate.strftime("%A -  %B %d, %Y - %I:%M %p"), admin_appointment_path(order.appointment)
     # end
     # end

  end

#appointmentdate.strftime("%A -  %B %d, %Y - %I:%M %p")

  show do

    panel "Invoice" do
      table_for(order.line_items) do |t|
        t.column("Service") {|item| auto_link item.product}
        t.column("Stylist Selected") {|item| auto_link item.product.author}
        t.column("Price")   {|item| number_to_currency item.price }
        tr :class => "odd" do
          td
          td "Total:", :style => "text-align: right;"
          td number_to_currency(order.total_price)
        end
      end
    end
    panel "Appointment Date" do

      attributes_table_for order.appointment do

        row :appointmentdate #do |r|
         # r.appointmentdate.strftime("%A -  %B %d, %Y - %I:%M %p")
       # end

      end
    end
  end

  sidebar :customer_information, :only => :show do
    attributes_table_for order.user do
      row("User") { auto_link order.user }
      row :email
      row :phone
    end
  end

  #sidebar "Active Admin Demo" do
   # render('/admin/sidebar_links', :model => 'orders')
 # end
end
