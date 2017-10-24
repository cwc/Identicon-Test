/**
 * identicon-c.h - Declaration of functions and data types to
 * generate an identicon.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef IDENTICON_H
#define IDENTICON_H

#include <stdint.h>
#include <stdbool.h>

#define IDENTICON_MAX_STRING_LENGTH 4096
#define IDENTICON_MAX_SALT_LENGTH 1024


// RGB color space
typedef struct identicon_RGB_t {
	uint8_t red;
	uint8_t green;
	uint8_t blue;
} identicon_RGB_t;

// Hash type
typedef enum identicon_hash_t {
	IDENTICON_HASH_MD5,
	IDENTICON_HASH_SHA1,
	IDENTICON_HASH_SHA256,
	IDENTICON_HASH_SHA512,
} identicon_hash_t;

// Identicon options
typedef struct identicon_options_t {
	char str[IDENTICON_MAX_STRING_LENGTH];
	char salt[IDENTICON_MAX_SALT_LENGTH];
	uint32_t size;
	double margin;
	bool transparent;
	bool stroke;
	uint32_t stroke_size;
	identicon_hash_t hash_type;
} identicon_options_t;


// Create a new set of default options
identicon_options_t *new_default_identicon_options();

// Create a new identicon
unsigned char *new_identicon(identicon_options_t *opts);

#endif
