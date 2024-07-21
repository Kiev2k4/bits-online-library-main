//src/utils/remove_undefined.js
export default function removeUndefined(obj) {
	for (let key in obj) {
		if (obj[key] === undefined) {
			delete obj[key];
		}
	}
	return obj;
}
