import { useCart } from "../context/CartContext";

const CartItem = ({ item }) => {
  const { dispatch } = useCart();

  return (
    <div className="cart-item border p-4 mb-2 rounded">
      <h3 className="cart-item-name text-lg">{item.name}</h3>
      <p className="cart-item-price">₹{item.price}</p>
      <button
        onClick={() => dispatch({ type: "REMOVE_FROM_CART", payload: item.id })}
        className="cart-remove-btn bg-red-500 text-white px-4 py-2 mt-2 rounded"
      >
        Remove
      </button>
    </div>
  );
};

export default CartItem;
