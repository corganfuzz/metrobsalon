ActiveAdmin.register_page "Dashboard" do
  menu :priority => 1
  content :title => proc{ I18n.t("active_admin.dashboard") } do

    columns do

      column do
        panel "Recent Orders" do
          table_for Order.complete.order('id desc').limit(10) do
            column("Order", :sortable => :id) {|order| link_to "##{order.id} ", admin_order_path(order) }
            column("State")   {|order| status_tag(order.state) }
            column("Ordered on", :checked_out_at)
            column("Customer"){|order| link_to(order.user.username, admin_customer_path(order.user)) }
            column("Total")   {|order| number_to_currency order.total_price}
          end
        end
      end

      column do
        panel "Recent Customers" do

          table_for User.order('id desc').limit(10).each do |customer|
            column("Customer")    {|customer| link_to(customer.username, admin_customer_path(customer)) }
           # column(:email)    {|customer| link_to(customer.email, admin_customer_path(customer)) }
            column("Registered on", :created_at)
          end
        end
      end

      column do
        panel "Recent Appointments" do

          table_for Appointment.order('id desc').limit(10).each do |appointment|

            column("Order", :order) #, :sortable => :order_id)
            #column("Order")   {|order| number_to_currency order.total_price                       }
            #column(:appointmentdate)    {|appointment| link_to(appointment.appointmentdate.strftime("%A - %B %d, %Y - %I:%M %p"), admin_appointment_path(appointment)) }
            column("Appointment Date", :appointmentdate)
            column("Booked", :booked)

          end

        end
      end

    end # columns

    #columns do

      #column do
      #  div do
      #    br
      #    text_node %{<iframe src="https://rpm.newrelic.com/public/charts/6VooNO2hKWB" width="500" height="300" scrolling="no" frameborder="no"></iframe>}.html_safe
    #    end
    #  end

      #column do
      #  panel "ActiveAdmin Demo" do
       #   div do
         #   render('/admin/sidebar_links', :model => 'dashboard')
       #   end
       # end
     # end

    #end # columns

    # Define your dashboard sections here. Each block will be
    # rendered on the dashboard in the context of the view. So just
    # return the content which you would like to display.

    # The dashboard is organized in rows and columns, where each row
    # divides the space for its child columns equally.

    # To start a new row, open a new 'columns' block, and to start a
    # new column, open a new 'colum' block. That way, you can exactly
    # define the position for each content div.

    # == Simple Dashboard Column
    # Here is an example of a simple dashboard column
    #
    #   column do
    #     panel "Recent Posts" do
    #       content_tag :ul do
    #         Post.recent(5).collect do |post|
    #           content_tag(:li, link_to(post.title, admin_post_path(post)))
    #         end.join.html_safe
    #       end
    #     end
    #   end

    # == Render Partials
    # The block is rendererd within the context of the view, so you can
    # easily render a partial rather than build content in ruby.
    #
    #   column do
    #     panel "Recent Posts" do
    #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
    #     end
    #   end

  end # content
end
