-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 25 Kas 2019, 00:50:17
-- Sunucu sürümü: 10.4.6-MariaDB
-- PHP Sürümü: 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `vallet`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `activities`
--

CREATE TABLE `activities` (
  `id` int(11) NOT NULL,
  `money` double DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `activities`
--

INSERT INTO `activities` (`id`, `money`, `categoryId`, `userId`) VALUES
(1, 500, 1, 1);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `bankcards`
--

CREATE TABLE `bankcards` (
  `id` int(11) NOT NULL,
  `totalAmount` int(11) DEFAULT NULL,
  `cardName` varchar(45) DEFAULT NULL,
  `cardTypeId` int(11) DEFAULT NULL,
  `cardNumber` varchar(45) DEFAULT NULL,
  `expiredDate` datetime DEFAULT NULL,
  `cvv` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `bankcards`
--

INSERT INTO `bankcards` (`id`, `totalAmount`, `cardName`, `cardTypeId`, `cardNumber`, `expiredDate`, `cvv`, `userId`) VALUES
(1, 200, 'Tunjay Huseynov', 1, '1234 5678 9123 4567', '2022-10-20 00:00:00', 354, 1),
(2, 500, 'Tunjay Huseynov', 1, '9876 6457 4561 4564', '2023-11-20 00:00:00', 355, 1);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `cardtypes`
--

CREATE TABLE `cardtypes` (
  `id` int(11) NOT NULL,
  `type` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `cardtypes`
--

INSERT INTO `cardtypes` (`id`, `type`) VALUES
(1, 'Visa'),
(2, 'Mastercard'),
(3, 'Umico');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Withdraw'),
(2, 'Transfer'),
(3, 'Shoping');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `image` text DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `cardId` int(11) DEFAULT NULL,
  `money` double DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `transactions`
--

INSERT INTO `transactions` (`id`, `image`, `categoryId`, `cardId`, `money`, `name`, `userId`, `date`) VALUES
(1, 'http://rubus.az/wp-content/uploads/2016/11/Bravo_market_logo_123112-300x96.png', 3, 1, 50, 'Bravo Market', 1, '2019-11-24 00:00:00'),
(2, 'https://kontakt.az/wp-content/uploads/2016/08/logoyeni-1.png', 3, 1, 150, 'Kontakt Home', 1, '2019-11-24 00:00:00'),
(3, 'http://rubus.az/wp-content/uploads/2016/11/Bravo_market_logo_123112-300x96.png', 3, 1, 70, 'Bravo Market', 1, '2019-11-15 00:00:00'),
(4, 'http://rubus.az/wp-content/uploads/2016/11/Bravo_market_logo_123112-300x96.png', 3, 2, 20, 'Bravo Market', 1, '2019-11-20 00:00:00'),
(5, 'http://rubus.az/wp-content/uploads/2016/11/Bravo_market_logo_123112-300x96.png', 1, 1, 80, 'Bravo Market', 1, '2019-11-24 00:00:00'),
(6, 'http://rubus.az/wp-content/uploads/2016/11/Bravo_market_logo_123112-300x96.png', 1, 1, 145, 'Bravo Market', 1, '2019-11-24 00:00:00'),
(7, 'http://rubus.az/wp-content/uploads/2016/11/Bravo_market_logo_123112-300x96.png', 2, 2, 300, 'Bravo Market', 1, '2019-11-24 00:00:00'),
(8, 'http://rubus.az/wp-content/uploads/2016/11/Bravo_market_logo_123112-300x96.png', 2, 1, 10, 'Bravo Market', 1, '2019-11-24 00:00:00');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `surname` varchar(45) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  `password` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `users`
--

INSERT INTO `users` (`id`, `name`, `surname`, `date`, `username`, `password`) VALUES
(1, 'Tuncay', 'Huseynov', '2019-07-10 00:00:00', 'tunjay98', '5591980');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `activities`
--
ALTER TABLE `activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userActivity` (`userId`),
  ADD KEY `categoryActivity` (`categoryId`);

--
-- Tablo için indeksler `bankcards`
--
ALTER TABLE `bankcards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cardType` (`cardTypeId`),
  ADD KEY `cardUser` (`userId`);

--
-- Tablo için indeksler `cardtypes`
--
ALTER TABLE `cardtypes`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categoryTransaction` (`categoryId`),
  ADD KEY `userTransaction` (`userId`),
  ADD KEY `cardTransaction` (`cardId`);

--
-- Tablo için indeksler `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `activities`
--
ALTER TABLE `activities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `bankcards`
--
ALTER TABLE `bankcards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Tablo için AUTO_INCREMENT değeri `cardtypes`
--
ALTER TABLE `cardtypes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Tablo için AUTO_INCREMENT değeri `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Tablo için AUTO_INCREMENT değeri `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Tablo için AUTO_INCREMENT değeri `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `activities`
--
ALTER TABLE `activities`
  ADD CONSTRAINT `categoryActivity` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `userActivity` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Tablo kısıtlamaları `bankcards`
--
ALTER TABLE `bankcards`
  ADD CONSTRAINT `cardType` FOREIGN KEY (`cardTypeId`) REFERENCES `cardtypes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `cardUser` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Tablo kısıtlamaları `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `cardTransaction` FOREIGN KEY (`cardId`) REFERENCES `bankcards` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `categoryTransaction` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `userTransaction` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
