use dep::noir_bigint;


struct Signed_Bigint {
    sign: bool,
    val: noir_bigint::BigUint56,
}

fn toSignedBigint(s: bool, v: noir_bigint::BigUint56) -> Signed_Bigint {
    
    let sb = Signed_Bigint {
        sign: s,
        val: v,
    };
    sb
}



fn val(sb: Signed_Bigint) -> noir_bigint::BigUint56 {
    sb.val
}

fn sign(sb: Signed_Bigint) -> bool {
    sb.sign
}

fn zero() -> Signed_Bigint {
    let b = noir_bigint::BigUint56 { limbs: [0 as u56; noir_bigint::NUM_LIMBS] };
    let sb = Signed_Bigint {
        sign: true,
        val: b,
    };
    sb
}

fn one() -> Signed_Bigint {
    let mut b = noir_bigint::BigUint56 { limbs: [0 as u56; noir_bigint::NUM_LIMBS] };
    b.limbs[0] = 1;
    let sb = Signed_Bigint {
        sign: true,
        val: b,
    };
    sb
}

fn negative_one() -> Signed_Bigint {
    let mut b = noir_bigint::BigUint56 { limbs: [0 as u56; noir_bigint::NUM_LIMBS] };
    b.limbs[0] = 1;
    let sb = Signed_Bigint {
        sign: false,
        val: b,
    };
    sb
}

fn from_u56(s: bool, v: u56) -> Signed_Bigint {
    let mut b = noir_bigint::BigUint56 { limbs: [0 as u56; noir_bigint::NUM_LIMBS] };
    b.limbs[0] = v;
    let sb = Signed_Bigint {
        sign: s,
        val: b,
    };
    sb
}

fn from_bytes(s: bool, bytes: [u8]) -> Signed_Bigint {
   
    let mut b = noir_bigint::BigUint56::from_bytes(bytes);
    let sb = Signed_Bigint {
        sign: s,
        val: b,
    };

    sb
}

fn to_bytes(sb: Signed_Bigint) -> (bool, [u8;noir_bigint::MAX_BYTES]) {
    let bytes = sb.val.to_bytes();
    (sb.sign, bytes)
}

fn to_bits(sb: Signed_Bigint) -> (bool, [u1;noir_bigint::MAX_BITS]) {
    let bits = sb.val.to_bits();
    (sb.sign, bits)
}

// a == b => 0
// a > b => 1
// a < b => 2
fn compare(sb1: Signed_Bigint, sb2: Signed_Bigint) -> u32 {
    if (sb1.sign != sb2.sign){
        if sb1.sign {
            1
        }
        else {
            2
        }
    }
    else {
        if sb1.val.eq(sb2.val){
            0
        }
        else {
            if sb1.sign {
                if sb1.val.gt(sb2.val){
                    1
                }
                else {
                    2
                }
            }
            else {
                if sb1.val.gt(sb2.val){
                    2
                }
                else {
                    1
                }
            }
        }
        
    }
}

fn isEqual(sb1: Signed_Bigint, sb2: Signed_Bigint) -> bool {
    if (sb1.sign != sb2.sign){
        false
    }
    else {
        sb1.val.eq(sb2.val)
    }
}

fn isNotEqual(sb1: Signed_Bigint, sb2: Signed_Bigint) -> bool {
    if (sb1.sign != sb2.sign){
        true
    }
    else {
        (!sb1.val.eq(sb2.val))
    }
}

fn isGreater(sb1: Signed_Bigint, sb2: Signed_Bigint) -> bool {
    if (sb1.sign != sb2.sign){
        if sb1.sign {
            true
        }
        else {
            false
        }
    }
    else {
        if sb1.sign {
            (sb1.val.gt(sb2.val))
        }
        else {
            (sb1.val.lt(sb2.val))
        }
    }
}

fn isGreaterOrEq(sb1: Signed_Bigint, sb2: Signed_Bigint) -> bool {
    if (sb1.sign != sb2.sign){
        if sb1.sign {
            true
        }
        else {
            false
        }
    }
    else {
        if sb1.sign {
            (sb1.val.gte(sb2.val))
        }
        else {
            (sb1.val.lte(sb2.val))
        }
    }
}

fn isLesser(sb1: Signed_Bigint, sb2: Signed_Bigint) -> bool {
    if (sb1.sign != sb2.sign){
        if sb1.sign {
            false
        }
        else {
            true
        }
    }
    else {
        if sb1.sign {
            (sb1.val.lt(sb2.val))
        }
        else {
            (sb1.val.gt(sb2.val))
        }
    }
}


fn isLesserOrEq(sb1: Signed_Bigint, sb2: Signed_Bigint) -> bool {
    if (sb1.sign != sb2.sign){
        if sb1.sign {
            false
        }
        else {
            true
        }
    }
    else {
        if sb1.sign {
            (sb1.val.lte(sb2.val))
        }
        else {
            (sb1.val.gte(sb2.val))
        }
    }
}

fn add(sb1: Signed_Bigint, sb2: Signed_Bigint) -> Signed_Bigint {
    if (sb1.sign == sb2.sign){
        let sum = sb1.val.add(sb2.val);
        let sb = Signed_Bigint {
            sign: sb1.sign,
            val: sum,
        };
        sb
    }
    else {
        if (sb1.val.gte(sb2.val)){
            let diff = sb1.val.sub(sb2.val);
            let sb = Signed_Bigint {
                sign: sb1.sign,
                val: diff,
            };
            sb
        }
        else {
            let diff = sb2.val.sub(sb1.val);
            let sb = Signed_Bigint {
                sign: sb2.sign,
                val: diff,
            };
            sb
        }
    }
}

fn subtract(sb1: Signed_Bigint, sb2: Signed_Bigint) -> Signed_Bigint {
    if (sb1.sign != sb2.sign){
        let sum = sb1.val.add(sb2.val);
        let sb = Signed_Bigint {
            sign: sb1.sign,
            val: sum,
        };
        sb
    }
    else {
        if (sb1.val.gte(sb2.val)){
            let diff = sb1.val.sub(sb2.val);
            let sb = Signed_Bigint {
                sign: sb1.sign,
                val: diff,
            };
            sb
        }
        else {
            let diff = sb2.val.sub(sb1.val);
            let sb = Signed_Bigint {
                sign: sb2.sign,
                val: diff,
            };
            sb
        }
    }
}

fn multiply(sb1: Signed_Bigint, sb2: Signed_Bigint) -> (Signed_Bigint, Signed_Bigint) {
    let mul = sb1.val.mul(sb2.val);
    let sblo = Signed_Bigint {
        sign: (sb1.sign == sb2.sign),
        val: mul.0,
    };
    let sbhi = Signed_Bigint {
        sign: (sb1.sign == sb2.sign),
        val: mul.1,
    };
    (sblo, sbhi)
}

fn divide(sb1: Signed_Bigint, sb2: Signed_Bigint) -> Signed_Bigint {
    let div = sb1.val.div(sb2.val);
    let sb = Signed_Bigint {
        sign: (sb1.sign == sb2.sign),
        val: div.0,
    };
    sb
}

fn remainder(sb1: Signed_Bigint, sb2: Signed_Bigint) -> Signed_Bigint {
    let div = sb1.val.div(sb2.val);
    let rem = div.1;
    if (sb1.sign == sb2.sign){
        let sb = Signed_Bigint {
            sign: (sb1.sign == sb2.sign),
            val: rem,
        };
        sb
    }
    else {
        let sb = Signed_Bigint {
            sign: (!sb1.sign),
            val: sb2.val.sub(rem),
        };
        sb
    }
    
}



#[test]
fn test_zero(){
    let z = zero();
    assert (z.val.limbs[0] == 0);
}

#[test]
fn test_one(){
    let z = one();
    assert (z.val.limbs[0] == 1);
}

#[test]
fn test_negative_one(){
    let z = negative_one();
    assert (z.val.limbs[0] == 1);
    assert (!z.sign);
}


#[test]
fn test_from_bytes1() {
    let bytes = [2 as u8];
    let a = from_bytes(true, bytes);
    assert(a.val.eq(noir_bigint::BigUint56{ limbs: [2, 0, 0, 0, 0] }));
}

#[test]
fn test_from_bytes2() {
    let bytes = [255 as u8; 7];
    let bi = noir_bigint::BigUint56{ limbs: [-1 as u56, 0, 0, 0, 0] };
    let a = from_bytes(true, bytes);
    let b = Signed_Bigint {
        sign: true,
        val: bi,
    };
    assert(isEqual(a, b));
}

#[test]
fn test_from_bytes3() {
    let bytes = [255 as u8; 8];
    let a = from_bytes(true, bytes);
    let b = Signed_Bigint {
        sign: true,
        val: noir_bigint::BigUint56{ limbs: [-1 as u56, 255, 0, 0, 0] },
    };
    assert(isEqual(a, b));
}



#[test]
fn test_add1() {
    let a = noir_bigint::BigUint56::from_bytes([1]);
    let b = noir_bigint::BigUint56::from_bytes([3]);
    let c = noir_bigint::BigUint56::from_bytes([4]);
    let sb1 = toSignedBigint(true, a);
    let sb2 = toSignedBigint(true, b);
    let sum = add(sb1, sb2);
    let other = toSignedBigint(true, c);
    assert (isEqual(sum, other));
}


#[test]
fn test_add2() {
    let a = noir_bigint::BigUint56::from_bytes([1]);
    let b = noir_bigint::BigUint56::from_bytes([3]);
    let c = noir_bigint::BigUint56::from_bytes([2]);
    let sb1 = toSignedBigint(false, a);
    let sb2 = toSignedBigint(true, b);
    let sum = add(sb1, sb2);
    let other = toSignedBigint(true, c);
    assert (isEqual(sum, other));
}

#[test]
fn test_subtract1() {
    let a = noir_bigint::BigUint56::from_bytes([11]);
    let b = noir_bigint::BigUint56::from_bytes([3]);
    let c = noir_bigint::BigUint56::from_bytes([8]);
    let sb1 = toSignedBigint(true, a);
    let sb2 = toSignedBigint(true, b);
    let diff = subtract(sb1, sb2);
    let other = toSignedBigint(true, c);
    assert (isEqual(diff, other));
}


#[test]
fn test_subtract2() {
    let a = noir_bigint::BigUint56::from_bytes([3]);
    let b = noir_bigint::BigUint56::from_bytes([2]);
    let c = noir_bigint::BigUint56::from_bytes([5]);
    let sb1 = toSignedBigint(false, a);
    let sb2 = toSignedBigint(true, b);
    let diff = subtract(sb1, sb2);
    let other = toSignedBigint(false, c);
    assert (isEqual(diff, other));
}