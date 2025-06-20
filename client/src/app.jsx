import React, { useEffect, useRef, useState } from 'react';
import { io } from 'socket.io-client';
import { Line } from 'react-chartjs-2';
import {
  Chart as ChartJS,
  LineElement,
  PointElement,
  CategoryScale,
  LinearScale,
  TimeScale,
} from 'chart.js';
import 'chartjs-adapter-date-fns';

ChartJS.register(LineElement, PointElement, CategoryScale, LinearScale, TimeScale);

const socket = io('http://localhost:3001');

export default function App() {
  const chartRef = useRef(null);
  const [data, setData] = useState([]);

  useEffect(() => {
    socket.on('prices', rows => {
      const uniqueMap = new Map();

      rows.forEach(row => {
        const key = row.TS.replace(' ', 'T'); // Zmień na row.TS jeśli dostajesz duże litery
        uniqueMap.set(key, {
          x: new Date(key),
          y: row.PRICE,
        });
      });

      const chartPoints = Array.from(uniqueMap.values())
        .sort((a, b) => a.x - b.x);

      setData(chartPoints);

      if (chartRef.current) {
        chartRef.current.update();
      }

      console.log('chartPoints', chartPoints);
    });

    return () => socket.off('prices');
  }, []);

  const chartData = {
    datasets: [
      {
        label: 'Avg Price',
        data: data,
        borderColor: 'blue',
        tension: 0.1,
        pointRadius: 2,
      },
    ],
  };

  const options = {
    plugins: {
      title: {
        display: true,
        text: 'BTC/USD Price Chart',
        font: {
          size: 18,
          weight: 'bold',
        },
        color: 'black',
        align: 'center',
        padding: {
          top: 10,
          bottom: 20,
        },
      },
    },
    scales: {
      x: {
        type: 'time',
        time: {
          tooltipFormat: 'HH:mm:ss',
          displayFormats: {
            minute: 'HH:mm',
            second: 'HH:mm:ss',
          },
        },
        title: {
          display: true,
          text: 'Czas',
        },
      },
      y: {
        title: {
          display: true,
          text: 'Cena',
        },
      },
    },
  };

  return <Line ref={chartRef} data={chartData} options={options} />;
}
