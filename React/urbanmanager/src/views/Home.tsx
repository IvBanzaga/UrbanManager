import { useAuth0 } from "@auth0/auth0-react";
import axios from "axios";

const Home = () => {
  const { user, isAuthenticated, getAccessTokenSilently } = useAuth0();

  const callApi = async () => {
    try {
      const response = await axios.get(
        `${import.meta.env.VITE_API_SERVER_URL}/api/user`
      );

      console.log(response);

      const responseData = response.data;

      alert(responseData.message);
    } catch (error) {
      alert(error);
      console.error(error);
    }
  };

  const callPrivateApi = async () => {
    try {
      const token = await getAccessTokenSilently();
      const response = await axios.get(
        `${import.meta.env.VITE_API_SERVER_URL}/api/user`,
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      console.log(response);

      const responseData = response.data;

      alert(responseData);
    } catch (error) {
      alert(error);
      console.error(error);
    }
  };

  return (
    <div className="flex flex-col items-center justify-center w-full px-4 py-8 mx-auto max-w-screen-lg">
      <h1 className="mb-4 text-2xl font-bold text-center">Esta es la pagina de inicio.</h1>
      <div className="px-6 mb-4 text-justify">
        Esta pagina es accesible para todos los usuarios, pero si inicias sesion
        podras acceder a una API privada
      </div>
      {isAuthenticated ? (
        <div className="font-semibold text-green-500">
          Has iniciado sesion como {user?.name}{" "}
        </div>
      ) : (
        <div className="font-semibold text-red-500">
          Actualmente no has iniciado sesion
        </div>
      )}
      <div className="mt-4">
        <button
          onClick={callApi}
          className="px-4 py-2 font-bold text-white bg-blue-500 rounded hover:bg-blue-700"
        >
          Call Public API
        </button>
      </div>
      {isAuthenticated && (
        <div className="mt-4">
          <button
            onClick={callPrivateApi}
            className="px-4 py-2 font-bold text-white bg-green-500 rounded hover:bg-green-700"
          >
            Call Private API
          </button>
        </div>
      )}
    </div>
  );
};

export default Home;