class ChargesController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    raise ActiveRecord::RecordNotFound if product.nil?

    # Amount in cents
    @amount = product.price

    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )

    @charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'usd'
    )
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end