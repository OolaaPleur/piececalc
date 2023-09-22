'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "706baadb6b77fd586db3f517236c7c41",
"assets/AssetManifest.json": "4ffa615dc493d1c7e0ef94935bb7cba5",
"assets/assets/chart.png": "fde4eb0efcf818982b957c6667172064",
"assets/assets/empty_archive.png": "c91f9dbe008783ebce216ab23651af05",
"assets/assets/google_fonts/NotoSans-Black.ttf": "7344fa7bfdc91692c2005063dfd8d9e5",
"assets/assets/google_fonts/NotoSans-BlackItalic.ttf": "cf36d264a78d3f4a38f18bebfb5038d7",
"assets/assets/google_fonts/NotoSans-Bold.ttf": "b20e2d260790596b6f6624a42b9c7833",
"assets/assets/google_fonts/NotoSans-BoldItalic.ttf": "6a1b004f6b834a3a3099373655ede470",
"assets/assets/google_fonts/NotoSans-ExtraBold.ttf": "378d7e386ebfc63cad4207bc36d9fa70",
"assets/assets/google_fonts/NotoSans-ExtraBoldItalic.ttf": "285f7e7574c615cbaf3df920e29ef73a",
"assets/assets/google_fonts/NotoSans-ExtraLight.ttf": "c6c6709da314a8eb047ac35f78f893d5",
"assets/assets/google_fonts/NotoSans-ExtraLightItalic.ttf": "37ee89e1855203861e90a9ec53485b3a",
"assets/assets/google_fonts/NotoSans-Italic.ttf": "d50ffd77a2f06bfbc2a3920791f514e3",
"assets/assets/google_fonts/NotoSans-Light.ttf": "1632b83b314172172674db7afca635e4",
"assets/assets/google_fonts/NotoSans-LightItalic.ttf": "dedeafd9f7da36c19776d02af364fb75",
"assets/assets/google_fonts/NotoSans-Medium.ttf": "42b6fa652971de0a49b3df511da65245",
"assets/assets/google_fonts/NotoSans-MediumItalic.ttf": "2e4cd15e722fee636b948530e5d34e74",
"assets/assets/google_fonts/NotoSans-Regular.ttf": "2a1861cd1ca7030ae9bb29f3192bb1e3",
"assets/assets/google_fonts/NotoSans-SemiBold.ttf": "4723ed1f1d9485302c3bb3e65e3d7693",
"assets/assets/google_fonts/NotoSans-SemiBoldItalic.ttf": "d53704fe638070e1c9daf54b52d72a14",
"assets/assets/google_fonts/NotoSans-Thin.ttf": "1034494a64fe1fb6ad155b46c994ead3",
"assets/assets/google_fonts/NotoSans-ThinItalic.ttf": "49a44940bfb71660a962bfacc2fda103",
"assets/assets/google_fonts/OFL.txt": "053f21bb22e6d0bee98b6610ec19d521",
"assets/assets/intro/intro_fifth_page.png": "c3d6ea867af152b3a5e6b323913e8881",
"assets/assets/intro/intro_fourth_page.png": "ac8d13ff0fe5ae54e9cd6d4fdbd8c30c",
"assets/assets/intro/intro_second_screen.png": "7554dd594bbef1e105f32d0d68d87b1b",
"assets/assets/intro/intro_seventh_page.png": "9c964fb2925b4c6dfa3347f4c247226d",
"assets/assets/intro/intro_theme_change.png": "33744f4f201de3447b2c0ae8ae428efa",
"assets/assets/intro/intro_third_page.png": "8bc58089df8db2da8553e3216245109e",
"assets/assets/launcher_icon.png": "f3b1c2b3e4c6edf98b4cd061e1cf76ef",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "60bb0004f72f19d92a6cc9eaf6960ac5",
"assets/NOTICES": "916cd19b4aafed98b0e9a64bdce2dd0f",
"assets/packages/currency_picker/lib/src/res/no_flag.png": "3f454777dfe9b6aae5e9d8544f4fa6f6",
"assets/packages/currency_picker/lib/src/res/xof.png": "5843e487ecffd9d3dcd01c1070cc6c6a",
"assets/packages/flex_color_picker/assets/opacity.png": "49c4f3bcb1b25364bb4c255edcaaf5b2",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"canvaskit/canvaskit.js": "bbf39143dfd758d8d847453b120c8ebb",
"canvaskit/canvaskit.wasm": "19d8b35640d13140fe4e6f3b8d450f04",
"canvaskit/chromium/canvaskit.js": "96ae916cd2d1b7320fff853ee22aebb0",
"canvaskit/chromium/canvaskit.wasm": "1165572f59d51e963a5bf9bdda61e39b",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "d1fde2560be92c0b07ad9cf9acb10d05",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "b6fb2147bd98a24b2842ac412c804373",
"/": "b6fb2147bd98a24b2842ac412c804373",
"main.dart.js": "529c4784a3fa785bc18e9af97195d0b5",
"manifest.json": "6a246c6cc5d737d73b55f12de12b98f7",
"sqflite_sw.js": "5267f89a5a1aa5a985f5cc30f85e3def",
"sqlite3.wasm": "2068781fd3a05f89e76131a98da09b5b",
"version.json": "43e59b2a887d4acd933e8d00f3eb4645"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
