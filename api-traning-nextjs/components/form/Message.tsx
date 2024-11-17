import { LoginResponse } from '@/types/api/response/types';

interface MessageProps {
  loginResponse: LoginResponse | undefined;
}

const Message = ({ loginResponse }: MessageProps) => {
  return (
    <div className="my-3">
      {loginResponse && 'message' in loginResponse && (
        <p className="text-green-500 font-bold">{loginResponse.message}</p>
      )}
      {loginResponse && 'error' in loginResponse && (
        <p className="text-red-500 font-bold">{loginResponse.error}</p>
      )}
    </div>
  );
};

export default Message;
