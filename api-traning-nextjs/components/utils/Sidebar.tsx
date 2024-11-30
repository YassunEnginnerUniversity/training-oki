import { Home } from 'lucide-react';
import Link from 'next/link';
import { cn } from '@/lib/utils';

export const Sidebar = () => {
  const sidebarItem = [{ icon: Home, label: 'ホーム', link: '/' }];

  return (
    <div className="w-64 h-screen bg-background border-r fixed top-[92px] left-0 bg-white z-10 overflow-y-auto">
      <div className="p-4">
        <nav className="space-y-2">
          {sidebarItem.map((item) => (
            <Link
              href={item.link}
              key={item.label}
              className={cn(
                'flex items-center w-full px-3 py-2 text-lg font-medium rounded-md',
                'text-gray-700 hover:text-gray-900 hover:bg-gray-100',
                'transition-colors duration-200',
              )}
            >
              <item.icon className="mr-4 h-6 w-6" />
              {item.label}
            </Link>
          ))}
        </nav>
      </div>
    </div>
  );
};
