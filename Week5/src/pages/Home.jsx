

import { useState } from "react";
import ProductCard from "../components/ProductCard";

const HomePage = () => {
  const [searchQuery, setSearchQuery] = useState("");

  const products = [
    { id: 1, name: "LG", price: 40000 },
    { id: 2, name: "Daikin", price: 50000 },
    { id: 3, name: "Samsung", price: 35000 },
    { id: 4, name: "Panasonic", price: 29000 },
  ];

  const filteredProducts = products.filter((product) =>
    product.name.toLowerCase().includes(searchQuery.toLowerCase())
  );

  return (
    <div className="home-page p-4">
      <h1 className="home-title text-2xl font-bold mb-4">Air Conditioner</h1>

      <input
        type="text"
        placeholder="Search products..."
        value={searchQuery}
        onChange={(e) => setSearchQuery(e.target.value)}
        className="border p-2 mb-4 w-full rounded"
      />

      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        {filteredProducts.length > 0 ? (
          filteredProducts.map((product) => (
            <ProductCard key={product.id} product={product} />
          ))
        ) : (
          <p className="text-gray-500">No products found.</p>
        )}
      </div>
    </div>
  );
};

export default HomePage;



// import ProductCard from "../components/ProductCard.jsx";

// const products = [
//   { id: 1, name: "LG", price: 40000 },
//   { id: 2, name: "Daikin", price: 50000 },
//   { id: 3, name: "Samsung", price: 35000 },
//   { id: 3, name: "Panasonic", price: 29000 },
// ];

// const HomePage = () => {
//   return (
//     <div className="home-page p-4">
//       <h1 className="home-title text-2xl font-bold mb-4">Products</h1>
//       <div className="home-product-grid grid grid-cols-1 md:grid-cols-3 gap-4">
//         {products.map((product) => (
//           <ProductCard key={product.id} product={product} />
//         ))}
//       </div>
//     </div>
//   );
// };

// export default HomePage;
