--
-- Premake 4.x build configuration script
--

--
-- Define the project. Put the release configuration first so it will be the
-- default when folks build using the makefile. That way they don't have to
-- worry about the /scripts argument and all that.
--

function joinTables(...)
	t0 = {}
	for i,t in ipairs(arg) do
        for k,v in ipairs(t) do table.insert(t0, v) end
	end
	return t0
end

	solution "Lua53_1"
		configurations { "Release", "Debug" }
		--location ( _OPTIONS["to"] )
		local build_location = "../build"
		location (build_location)
		configuration "Debug"
			targetdir  (build_location .. "/bin/debug")
			implibdir  (build_location .. "/bin/debug")
			defines     "_DEBUG"
			flags       { "Symbols" }

		configuration "Release"
			targetdir (build_location .. "/bin/release")
			implibdir (build_location .. "/bin/release")
			defines     "NDEBUG"
			flags       { "OptimizeSize" }

		configuration "vs*"
			defines     { "_CRT_SECURE_NO_WARNINGS" }

		configuration "vs2005"
			defines	{"_CRT_SECURE_NO_DEPRECATE" }

		configuration "windows"
			defines { "_WIN32" }
			links { "ole32" }

		configuration "linux or bsd or hurd"
			defines     { "LUA_USE_POSIX", "LUA_USE_DLOPEN" }
			links       { "m" }
			linkoptions { "-rdynamic" }

		configuration "linux"
			links       { "dl" }

		configuration "hurd"
			links       { "dl" }

		configuration "macosx"
			defines     { "LUA_USE_MACOSX" }
			links       { "CoreServices.framework" }

		configuration { "macosx", "gmake" }
			-- toolset "clang"  (not until a 5.0 binary is available)
			buildoptions { "-mmacosx-version-min=10.4" }
			linkoptions  { "-mmacosx-version-min=10.4" }

		configuration { "solaris" }
			linkoptions { "-Wl,--export-dynamic" }		

		configuration "aix"
			defines     { "LUA_USE_POSIX", "LUA_USE_DLOPEN" }
			links       { "m" }
		configuration()

		-----------------------------------------------------------------------------------------------------------------------------

        lapi_o = { "lapi.c", "lprefix.h",  "lua.h",  "luaconf.h",  "lapi.h",  "llimits.h",  "lstate.h",  "lobject.h",  "ltm.h",  "lzio.h",  "lmem.h",  "ldebug.h",  "ldo.h",  "lfunc.h",  "lgc.h",  "lstring.h",  "ltable.h",  "lundump.h",  "lvm.h",  }
        lauxlib_o = { "lauxlib.c", "lprefix.h",  "lua.h",  "luaconf.h",  "lauxlib.h",  }
        lbaselib_o = { "lbaselib.c", "lprefix.h",  "lua.h",  "luaconf.h",  "lauxlib.h",  "lualib.h",  }
        lbitlib_o = { "lbitlib.c", "lprefix.h",  "lua.h",  "luaconf.h",  "lauxlib.h",  "lualib.h",  }
        lcode_o = { "lcode.c", "lprefix.h",  "lua.h",  "luaconf.h",  "lcode.h",  "llex.h",  "lobject.h",  "llimits.h",  "lzio.h",  "lmem.h",  "lopcodes.h",  "lparser.h",  "ldebug.h",  "lstate.h",  "ltm.h",  "ldo.h",  "lgc.h",  "lstring.h",  "ltable.h",  "lvm.h",  }
        lcorolib_o = { "lcorolib.c", "lprefix.h",  "lua.h",  "luaconf.h",  "lauxlib.h",  "lualib.h",  }
        lctype_o = { "lctype.c", "lprefix.h", "lctype.h",  "lua.h",  "luaconf.h",  "llimits.h",  }
        ldblib_o = { "ldblib.c", "lprefix.h", "lua.h",  "luaconf.h",  "lauxlib.h",  "lualib.h",  }
        ldebug_o = { "ldebug.c", "lprefix.h", "lua.h",  "luaconf.h",  "lapi.h",  "llimits.h",  "lstate.h",  "lobject.h",  "ltm.h",  "lzio.h",  "lmem.h",  "lcode.h",  "llex.h",  "lopcodes.h",  "lparser.h",  "ldebug.h",  "ldo.h",  "lfunc.h",  "lstring.h",  "lgc.h",  "ltable.h",  "lvm.h",  }
        ldo_o = { "ldo.c", "lprefix.h", "lua.h",  "luaconf.h",  "lapi.h",  "llimits.h",  "lstate.h",  "lobject.h",  "ltm.h",  "lzio.h",  "lmem.h",  "ldebug.h",  "ldo.h",  "lfunc.h",  "lgc.h",  "lopcodes.h",  "lparser.h",  "lstring.h",  "ltable.h",  "lundump.h",  "lvm.h",  }
        ldump_o = { "ldump.c",  "lua.h",  "luaconf.h",  "lobject.h",  "llimits.h",  "lstate.h",  "ltm.h",  "lzio.h",  "lmem.h",  "lundump.h",  }
        lfunc_o = { "lfunc.c", "lprefix.h", "lua.h",  "luaconf.h",  "lfunc.h",  "lobject.h",  "llimits.h",  "lgc.h",  "lstate.h",  "ltm.h",  "lzio.h",  "lmem.h",  }
        lgc_o = { "lgc.c", "lprefix.h", "lua.h",  "luaconf.h",  "ldebug.h",  "lstate.h",  "lobject.h",  "llimits.h",  "ltm.h",  "lzio.h",  "lmem.h",  "ldo.h",  "lfunc.h",  "lgc.h",  "lstring.h",  "ltable.h",  }
        linit_o = { "linit.c", "lprefix.h", "lua.h",  "luaconf.h",  "lualib.h",  "lauxlib.h",  }
        liolib_o = { "liolib.c", "lprefix.h", "lua.h",  "luaconf.h",  "lauxlib.h",  "lualib.h",  }
        llex_o = { "llex.c", "lprefix.h", "lua.h",  "luaconf.h",  "lctype.h",  "llimits.h",  "ldo.h",  "lobject.h",  "lstate.h",  "ltm.h",  "lzio.h",  "lmem.h",  "llex.h",  "lparser.h",  "lstring.h",  "lgc.h",  "ltable.h",  }
        lmathlib_o = { "lmathlib.c", "lprefix.h", "lua.h",  "luaconf.h",  "lauxlib.h",  "lualib.h",  }
        lmem_o = { "lmem.c", "lprefix.h", "lua.h",  "luaconf.h",  "ldebug.h",  "lstate.h",  "lobject.h",  "llimits.h",  "ltm.h",  "lzio.h",  "lmem.h",  "ldo.h",  "lgc.h",  }
        loadlib_o = { "loadlib.c", "lprefix.h", "lua.h",  "luaconf.h",  "lauxlib.h",  "lualib.h",  }
        lobject_o = { "lobject.c", "lprefix.h", "lua.h",  "luaconf.h",  "lctype.h",  "llimits.h",  "ldebug.h",  "lstate.h",  "lobject.h",  "ltm.h",  "lzio.h",  "lmem.h",  "ldo.h",  "lstring.h",  "lgc.h",  "lvm.h",  }
        lopcodes_o = { "lopcodes.c", "lprefix.h", "lopcodes.h",  "llimits.h",  "lua.h",  "luaconf.h",  }
        loslib_o = { "loslib.c", "lprefix.h", "lua.h",  "luaconf.h",  "lauxlib.h",  "lualib.h",  }
        lparser_o = { "lparser.c", "lprefix.h", "lua.h",  "luaconf.h",  "lcode.h",  "llex.h",  "lobject.h",  "llimits.h",  "lzio.h",  "lmem.h",  "lopcodes.h",  "lparser.h",  "ldebug.h",  "lstate.h",  "ltm.h",  "ldo.h",  "lfunc.h",  "lstring.h",  "lgc.h",  "ltable.h",  }
        lstate_o = { "lstate.c", "lprefix.h", "lua.h",  "luaconf.h",  "lapi.h",  "llimits.h",  "lstate.h",  "lobject.h",  "ltm.h",  "lzio.h",  "lmem.h",  "ldebug.h",  "ldo.h",  "lfunc.h",  "lgc.h",  "llex.h",  "lstring.h",  "ltable.h",  }
        lstring_o = { "lstring.c","lprefix.h",  "lua.h",  "luaconf.h",  "lmem.h",  "llimits.h",  "lobject.h",  "lstate.h",  "ltm.h",  "lzio.h",  "lstring.h",  "lgc.h",  }
        lstrlib_o = { "lstrlib.c", "lprefix.h",  "lua.h",  "luaconf.h",  "lauxlib.h",  "lualib.h",  }
        ltable_o = { "ltable.c", "lprefix.h", "lua.h",  "luaconf.h",  "ldebug.h",  "lstate.h",  "lobject.h",  "llimits.h",  "ltm.h",  "lzio.h",  "lmem.h",  "ldo.h",  "lgc.h",  "lstring.h",  "ltable.h",  "lvm.h",  }
        ltablib_o = { "ltablib.c", "lprefix.h", "lua.h",  "luaconf.h",  "lauxlib.h",  "lualib.h",  }
        ltm_o = { "ltm.c", "lprefix.h", "lua.h",  "luaconf.h",  "lobject.h",  "llimits.h",  "lstate.h",  "ltm.h",  "lzio.h",  "lmem.h",  "lstring.h",  "lgc.h",  "ltable.h",  }
        lua_o = { "lua.c", "lprefix.h", "lua.h",  "luaconf.h",  "lauxlib.h",  "lualib.h",  }
        luac_o = { "luac.c", "lprefix.h", "lua.h",  "luaconf.h",  "lauxlib.h",  "lobject.h",  "llimits.h",  "lstate.h",  "ltm.h",  "lzio.h",  "lmem.h",  "lundump.h",  "ldebug.h",  "lopcodes.h",  }
        lundump_o = { "lundump.c", "lprefix.h", "lua.h",  "luaconf.h",  "ldebug.h",  "lstate.h",  "lobject.h",  "llimits.h",  "ltm.h",  "lzio.h",  "lmem.h",  "ldo.h",  "lfunc.h",  "lstring.h",  "lgc.h",  "lundump.h",  }
        lutf8lib_o = { "lutf8lib.c", "lprefix.h", "lua.h", "luaconf.h", "lauxlib.h", "lualib.h" }
        lvm_o = { "lvm.c", "lprefix.h", "lua.h",  "luaconf.h",  "ldebug.h",  "lstate.h",  "lobject.h",  "llimits.h",  "ltm.h",  "lzio.h",  "lmem.h",  "ldo.h",  "lfunc.h",  "lgc.h",  "lopcodes.h",  "lstring.h",  "ltable.h",  "lvm.h",  }
        lzio_o = { "lzio.c", "lprefix.h", "lua.h",  "luaconf.h",  "llimits.h",  "lmem.h",  "lstate.h",  "lobject.h",  "ltm.h",  "lzio.h", }

		
		LUA_A = "liblua.a"
		CORE_O = joinTables(lapi_o,lcode_o,lctype_o,ldebug_o,ldo_o,ldump_o,lfunc_o,lgc_o,llex_o,lmem_o,lobject_o,lopcodes_o,lparser_o,lstate_o,lstring_o,ltable_o,ltm_o,lundump_o,lutf8lib_o,lvm_o,lzio_o)

		LIB_O = joinTables(lauxlib_o,lbaselib_o,lbitlib_o,lcorolib_o,ldblib_o,liolib_o,lmathlib_o,loslib_o,lstrlib_o,ltablib_o,loadlib_o,linit_o)
		
		BASE_O = joinTables(CORE_O, LIB_O)

		LUA_T = "lua"
		LUA_O = lua_o
		LUAC_T = "luac"
		LUAC_O = luac_o
	----------------------------------------------------------------------------------------------------------------------------------------------

	project "lua"
		targetname  "lua"
		language    "C"
		kind        "ConsoleApp"
		flags       { "No64BitChecks", "ExtraWarnings", "StaticRuntime" }
		--includedirs { "src/host/lua-5.1.4/src" }

		files(LUA_O)

		configuration "windows"
			defines { "LUA_BUILD_AS_DLL" }
		configuration()
		links { "lua53_1lib" }

	project "lua53_1lib"
		targetname  "lua53_1"
		language    "C"
		kind        "SharedLib"
		flags       { "No64BitChecks", "ExtraWarnings", "StaticRuntime" }		

		files(BASE_O)

		configuration "windows"
			defines { "LUA_BUILD_AS_DLL" }
		configuration()		

 	project "luac"
		targetname  "luac"
		language    "C"
		kind        "ConsoleApp"
		flags       { "No64BitChecks", "ExtraWarnings", "StaticRuntime" }		
		
		files(LUAC_O)

		configuration "windows"
			defines { "LUA_BUILD_AS_DLL" }
		configuration()	
		links { "lua53_1lib" }
