ActiveAdmin.register Appointment do

  filter :appointmentdate
  filter :created_at
  filter :booked



  form do |f|
    f.inputs do
      f.input :order
     # f.input :user
      f.input :appointmentdate, :as => :datetime_picker#, :maxlegnth => 20
      f.input :booked
    end
    f.actions

    panel "Appointments History by order" do
      table_for Appointment.order('id desc').limit(10).each do |appointment|

        column("Order", :order)

        column("Appointment Date", :appointmentdate,  :sortable => 'appointmentdate')
      end
    end


  end
 show do
   attributes_table :appointmentdate, :booked, :order
   :content
 end

  index do

    selectable_column
    id_column
    column("Order with Customer", :order) #, :sortable => :order_id)

    column("Appointment Date", :appointmentdate)
    column("Booked", :booked)
    column("Created on", :created_at)
    actions

  end




  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
   permit_params :order_id, :user_id, :appointmentdate, :booked, :username, :user
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end
