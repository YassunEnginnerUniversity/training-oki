import { LoginResponse } from '@/types/api/response/types';
import { cn } from '@/lib/utils';

interface MessageProps {
  loginResponse: LoginResponse | undefined;
  className?: string;
}

const Message = ({ loginResponse, className }: MessageProps) => {
  return (
    <div className={cn('my-3', className)}>
      {loginResponse && 'message' in loginResponse && (
        <p className="text-green-500 font-medium rounded-md bg-green-50 dark:bg-green-950/30 px-3 py-2">
          {loginResponse.message}
        </p>
      )}
      {loginResponse && 'error' in loginResponse && (
        <p className="text-red-500 font-medium rounded-md bg-red-50 dark:bg-red-950/30 px-3 py-2">
          {loginResponse.error}
        </p>
      )}
    </div>
  );
};

export default Message;
