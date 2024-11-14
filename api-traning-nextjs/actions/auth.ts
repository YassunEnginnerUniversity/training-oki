'user server'
type LoginFormStateType = {
  success: boolean;
};

export const login = async (prevState: LoginFormStateType, formData: FormData): Promise<LoginFormStateType> => {
  const username = formData.get("username");
  const password = formData.get("password");

  console.log({user: {username: username, password: password}});
  
  await new Promise((resolve) => setTimeout(resolve, 3000));
  return { success: true };
};

