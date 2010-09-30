package com.swfwire.decompiler.abc
{
	import com.swfwire.decompiler.abc.instructions.*;
	
	import flash.utils.Dictionary;

	public class ABCInstructions
	{
		private static const instructionNames:Object =
		{
			0x01: '0x01',
			0x02: 'nop',
			0x03: 'throw',
			0x04: 'getsuper',
			0x05: 'setsuper',
			0x06: 'dxns',
			0x07: 'dxnslate',
			0x08: 'kill',
			0x09: 'label',
			0x0C: 'ifnlt',
			0x0D: 'ifnle',
			0x0E: 'ifngt',
			0x0F: 'ifnge',
			0x10: 'jump',
			0x11: 'iftrue',
			0x12: 'iffalse',
			0x13: 'ifeq',
			0x14: 'ifne',
			0x15: 'iflt',
			0x16: 'ifle',
			0x17: 'ifgt',
			0x18: 'ifge',
			0x19: 'ifstricteq',
			0x1A: 'ifstrictne',
			0x1B: 'lookupswitch',
			0x1C: 'pushwith',
			0x1D: 'popscope',
			0x1E: 'nextname',
			0x1F: 'hasnext',
			0x20: 'pushnull',
			0x21: 'pushundefined',
			0x23: 'nextvalue',
			0x24: 'pushbyte',
			0x25: 'pushshort',
			0x26: 'pushtrue',
			0x27: 'pushfalse',
			0x28: 'pushnan',
			0x29: 'pop',
			0x2A: 'dup',
			0x2B: 'swap',
			0x2C: 'pushstring',
			0x2D: 'pushint',
			0x2E: 'pushuint',
			0x2F: 'pushdouble',
			0x30: 'pushscope',
			0x31: 'pushnamespace',
			0x32: 'hasnext2',
			0x33: 'pushdecimal',
			0x40: 'newfunction',
			0x41: 'call',
			0x42: 'construct',
			0x43: 'callmethod',
			0x44: 'callstatic',
			0x45: 'callsuper',
			0x46: 'callproperty',
			0x47: 'returnvoid',
			0x48: 'returnvalue',
			0x49: 'constructsuper',
			0x4A: 'constructprop',
			0x4B: 'callsuperid',
			0x4C: 'callproplex',
			0x4D: 'callinterface',
			0x4E: 'callsupervoid',
			0x4F: 'callpropvoid',
			0x53: 'applytype',
			0x55: 'newobject',
			0x56: 'newarray',
			0x57: 'newactivation',
			0x58: 'newclass',
			0x59: 'getdescendants',
			0x5A: 'newcatch',
			0x5D: 'findpropstrict',
			0x5E: 'findproperty',
			0x5F: 'finddef',
			0x60: 'getlex',
			0x61: 'setproperty',
			0x62: 'getlocal',
			0x63: 'setlocal',
			0x64: 'getglobalscope',
			0x65: 'getscopeobject',
			0x66: 'getproperty',
			0x67: 'getpropertylate',
			0x68: 'initproperty',
			0x69: 'setpropertylate',
			0x6A: 'deleteproperty',
			0x6B: 'deletepropertylate',
			0x6C: 'getslot',
			0x6D: 'setslot',
			0x6E: 'getglobalslot',
			0x6F: 'setglobalslot',
			0x70: 'convert_s',
			0x71: 'esc_xelem',
			0x72: 'esc_xattr',
			0x73: 'convert_i',
			0x74: 'convert_u',
			0x75: 'convert_d',
			0x76: 'convert_b',
			0x77: 'convert_o',
			0x80: 'coerce',
			0x81: 'coerce_b',
			0x82: 'coerce_a',
			0x83: 'coerce_i',
			0x84: 'coerce_d',
			0x85: 'coerce_s',
			0x86: 'astype',
			0x87: 'astypelate',
			0x88: 'coerce_u',
			0x89: 'coerce_o',
			0x90: 'negate',
			0x91: 'increment',
			0x92: 'inclocal',
			0x93: 'decrement',
			0x94: 'declocal',
			0x95: 'typeof',
			0x96: 'not',
			0x97: 'bitnot',
			0x9A: 'concat',
			0x9B: 'add_d',
			0xA0: 'add',
			0xA1: 'subtract',
			0xA2: 'multiply',
			0xA3: 'divide',
			0xA4: 'modulo',
			0xA5: 'lshift',
			0xA6: 'rshift',
			0xA7: 'urshift',
			0xA8: 'bitand',
			0xA9: 'bitor',
			0xAA: 'bitxor',
			0xAB: 'equals',
			0xAC: 'strictequals',
			0xAD: 'lessthan',
			0xAE: 'lessequals',
			0xAF: 'greaterthan',
			0xB0: 'greaterequals',
			0xB1: 'instanceof',
			0xB2: 'istype',
			0xB3: 'istypelate',
			0xB4: 'in',
			0xC0: 'increment_i',
			0xC1: 'decrement_i',
			0xC2: 'inclocal_i',
			0xC3: 'declocal_i',
			0xC4: 'negate_i',
			0xC5: 'add_i',
			0xC6: 'subtract_i',
			0xC7: 'multiply_i',
			0xD0: 'getlocal0',
			0xD1: 'getlocal1',
			0xD2: 'getlocal2',
			0xD3: 'getlocal3',
			0xD4: 'setlocal0',
			0xD5: 'setlocal1',
			0xD6: 'setlocal2',
			0xD7: 'setlocal3',
			0xEF: 'debug',
			0xF0: 'debugline',
			0xF1: 'debugfile',
			0xF2: 'bkptline'
		};
		private static const instructionClasses:Object =
		{
			0x01: Instruction_0x01,
			0x02: Instruction_nop,
			0x03: Instruction_throw,
			0x04: Instruction_getsuper,
			0x05: Instruction_setsuper,
			0x06: Instruction_dxns,
			0x07: Instruction_dxnslate,
			0x08: Instruction_kill,
			0x09: Instruction_label,
			0x0C: Instruction_ifnlt,
			0x0D: Instruction_ifnle,
			0x0E: Instruction_ifngt,
			0x0F: Instruction_ifnge,
			0x10: Instruction_jump,
			0x11: Instruction_iftrue,
			0x12: Instruction_iffalse,
			0x13: Instruction_ifeq,
			0x14: Instruction_ifne,
			0x15: Instruction_iflt,
			0x16: Instruction_ifle,
			0x17: Instruction_ifgt,
			0x18: Instruction_ifge,
			0x19: Instruction_ifstricteq,
			0x1A: Instruction_ifstrictne,
			0x1B: Instruction_lookupswitch,
			0x1C: Instruction_pushwith,
			0x1D: Instruction_popscope,
			0x1E: Instruction_nextname,
			0x1F: Instruction_hasnext,
			0x20: Instruction_pushnull,
			0x21: Instruction_pushundefined,
			0x23: Instruction_nextvalue,
			0x24: Instruction_pushbyte,
			0x25: Instruction_pushshort,
			0x26: Instruction_pushtrue,
			0x27: Instruction_pushfalse,
			0x28: Instruction_pushnan,
			0x29: Instruction_pop,
			0x2A: Instruction_dup,
			0x2B: Instruction_swap,
			0x2C: Instruction_pushstring,
			0x2D: Instruction_pushint,
			0x2E: Instruction_pushuint,
			0x2F: Instruction_pushdouble,
			0x30: Instruction_pushscope,
			0x31: Instruction_pushnamespace,
			0x32: Instruction_hasnext2,
			0x35: Instruction_li8,
			0x36: Instruction_li16,
			0x37: Instruction_li32,
			0x38: Instruction_lf32,
			0x39: Instruction_lf64,
			0x3A: Instruction_si8,
			0x3B: Instruction_si16,
			0x3C: Instruction_si32,
			0x3D: Instruction_sf32,
			0x3E: Instruction_sf64,
			0x40: Instruction_newfunction,
			0x41: Instruction_call,
			0x42: Instruction_construct,
			0x43: Instruction_callmethod,
			0x44: Instruction_callstatic,
			0x45: Instruction_callsuper,
			0x46: Instruction_callproperty,
			0x47: Instruction_returnvoid,
			0x48: Instruction_returnvalue,
			0x49: Instruction_constructsuper,
			0x4A: Instruction_constructprop,
			0x4C: Instruction_callproplex,
			0x4E: Instruction_callsupervoid,
			0x4F: Instruction_callpropvoid,
			0x50: Instruction_sxi1,
			0x51: Instruction_sxi8,
			0x52: Instruction_sxi16,
			0x53: Instruction_applytype,
			0x55: Instruction_newobject,
			0x56: Instruction_newarray,
			0x57: Instruction_newactivation,
			0x58: Instruction_newclass,
			0x59: Instruction_getdescendants,
			0x5A: Instruction_newcatch,
			0x5B: Instruction_findpropglobalstrict,
			0x5C: Instruction_findpropglobal,
			0x5D: Instruction_findpropstrict,
			0x5E: Instruction_findproperty,
			0x5F: Instruction_finddef,  
			0x60: Instruction_getlex,
			0x61: Instruction_setproperty,
			0x62: Instruction_getlocal,
			0x63: Instruction_setlocal,
			0x64: Instruction_getglobalscope,
			0x65: Instruction_getscopeobject,
			0x66: Instruction_getproperty,
			0x67: Instruction_getouterscope,
			0x68: Instruction_initproperty,
			0x6A: Instruction_deleteproperty,
			0x6C: Instruction_getslot,
			0x6D: Instruction_setslot,
			0x6E: Instruction_getglobalslot,
			0x6F: Instruction_setglobalslot,
			0x70: Instruction_convert_s,
			0x71: Instruction_esc_xelem,
			0x72: Instruction_esc_xattr,
			0x73: Instruction_convert_i,
			0x74: Instruction_convert_u,
			0x75: Instruction_convert_d,
			0x76: Instruction_convert_b,
			0x77: Instruction_convert_o,
			0x78: Instruction_checkfilter,
			0x80: Instruction_coerce,
			0x81: Instruction_coerce_b,
			0x82: Instruction_coerce_a,
			0x83: Instruction_coerce_i, 
			0x84: Instruction_coerce_d, 
			0x85: Instruction_coerce_s,
			0x86: Instruction_astype,
			0x87: Instruction_astypelate,
			0x88: Instruction_coerce_u,
			0x89: Instruction_coerce_o,
			0x90: Instruction_negate,
			0x91: Instruction_increment,
			0x92: Instruction_inclocal,
			0x93: Instruction_decrement,
			0x94: Instruction_declocal,
			0x95: Instruction_typeof,
			0x96: Instruction_not,
			0x97: Instruction_bitnot,
			0xA0: Instruction_add,
			0xA1: Instruction_subtract,
			0xA2: Instruction_multiply,
			0xA3: Instruction_divide,
			0xA4: Instruction_modulo,
			0xA5: Instruction_lshift,
			0xA6: Instruction_rshift,
			0xA7: Instruction_urshift,
			0xA8: Instruction_bitand,
			0xA9: Instruction_bitor,
			0xAA: Instruction_bitxor,
			0xAB: Instruction_equals,
			0xAC: Instruction_strictequals,
			0xAD: Instruction_lessthan,
			0xAE: Instruction_lessequals,
			0xAF: Instruction_greaterthan,
			0xB0: Instruction_greaterequals,
			0xB1: Instruction_instanceof,
			0xB2: Instruction_istype,
			0xB3: Instruction_istypelate,
			0xB4: Instruction_in,
			0xC0: Instruction_increment_i,
			0xC1: Instruction_decrement_i,
			0xC2: Instruction_inclocal_i,
			0xC3: Instruction_declocal_i,
			0xC4: Instruction_negate_i,
			0xC5: Instruction_add_i,
			0xC6: Instruction_subtract_i,
			0xC7: Instruction_multiply_i,
			0xD0: Instruction_getlocal0,
			0xD1: Instruction_getlocal1,
			0xD2: Instruction_getlocal2,
			0xD3: Instruction_getlocal3,
			0xD4: Instruction_setlocal0,
			0xD5: Instruction_setlocal1,
			0xD6: Instruction_setlocal2,
			0xD7: Instruction_setlocal3,
			//0xEE => abs_jump,
			0xEF: Instruction_debug,
			0xF0: Instruction_debugline,
			0xF1: Instruction_debugfile,
			0xF2: Instruction_0xF2
			//0xF3 => timestamp,
		};
		
		private static var instructionIds:Dictionary = new Dictionary();
		
		public static function getName(instructionId:uint):String
		{
			return instructionNames[instructionId];
		}
		public static function getClass(instructionId:uint):Class
		{
			return instructionClasses[instructionId];
		}
		public static function getId(instruction:Class):uint
		{
			return instructionIds[instruction];
		}
		
		private static function initialize():Boolean
		{
			for(var iter:String in instructionClasses)
			{
				instructionIds[instructionClasses[iter]] = uint(iter);
			}
			return true;
		}
		
		initialize();
	}
}