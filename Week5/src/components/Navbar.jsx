import { Link } from "react-router-dom";
import { useCart } from "../context/CartContext";

const Navbar = () => {
  const { cart } = useCart();

  return (
  <nav className="navbar bg-gradient-to-r from-purple-500 to-blue-500 p-5 text-white flex justify-between shadow-md">
  <Link to="/" className="navbar-title text-2xl font-extrabold tracking-widest">ShopKart</Link>
  <Link to="/cart" className="navbar-cart text-lg font-medium hover:text-yellow-300 transition">
    Cart ({cart.length})
  </Link>
</nav>
  );
};

export default Navbar;
