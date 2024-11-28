import { Loader2 } from 'lucide-react';

interface LoadingProps {
  size?: number;
  color?: string;
  text?: string;
}

export default function Loading({
  size = 24,
  color = 'text-gray-400', // Changed to a gray color
  text = 'Loading...',
}: LoadingProps) {
  return (
    <div className="flex flex-col items-center justify-center mt-6">
      <Loader2 className={`animate-spin ${color}`} size={size} />
      <p className="mt-4 text-sm font-medium text-gray-500" aria-live="polite">
        {text}
      </p>
    </div>
  );
}
