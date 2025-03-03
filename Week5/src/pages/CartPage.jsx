import { useCart } from "../context/CartContext.jsx";
import CartItem from "../components/CartItem.jsx";

const CartPage = () => {
  const { cart } = useCart();
  const totalPrice = cart.reduce((acc, item) => acc + item.price, 0);

  return (
    <div className="cart-page p-6 bg-gray-50 min-h-screen">
  <h2 className="cart-title text-3xl font-bold mb-6 text-gray-800">🛒 Your Shopping Cart</h2>
  {cart.length === 0 ? (
    <p className="cart-empty text-gray-600 text-lg">Your cart is empty...</p>
  ) : (
    <div className="cart-list grid gap-4">
      {cart.map((item) => <CartItem key={item.id} item={item} />)}
    </div>
  )}
  <h3 className="cart-total text-2xl font-semibold mt-6">Total: <span className="text-green-600">₹{totalPrice.toFixed(2)}</span></h3>
  </div>
  );
};

export default CartPage;
