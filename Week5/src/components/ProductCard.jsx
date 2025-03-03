


import { useCart } from "../context/CartContext";

const ProductCard = ({ product }) => {
  const { dispatch } = useCart();

  return (
    <div className="product-card border p-4 rounded-lg shadow-md bg-white hover:shadow-lg transition duration-300 transform hover:scale-105">
  <h2 className="product-name text-xl font-bold text-gray-800">{product.name}</h2>
  <p className="product-price text-gray-600">₹{product.price}</p>
  <button
    onClick={() => dispatch({ type: "ADD_TO_CART", payload: product })}
    className="product-add-btn bg-green-500 text-white px-5 py-2 mt-3 rounded-lg shadow-md hover:bg-green-600 transition">
    Add to Cart
  </button>
</div>
  );
};

export default ProductCard;
