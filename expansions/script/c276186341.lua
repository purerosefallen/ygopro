--恋爱的少女
function c276186341.initial_effect(c)
	--battle indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	e1:SetCondition(c276186341.indcon)
	c:RegisterEffect(e1)
	--lv
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(276186341,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e2:SetCountLimit(1)
	e2:SetTarget(c276186341.lvtg)
	e2:SetOperation(c276186341.lvop)
	c:RegisterEffect(e2)
	--love
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e3:SetValue(c276186341.tgval)
	c:RegisterEffect(e3)
	--spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(276186341,0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e4:SetCountLimit(1,276186341)
	e4:SetHintTiming(0,TIMING_END_PHASE)
	e4:SetCost(c276186341.spcost)
	e4:SetTarget(c276186341.sptg)
	e4:SetOperation(c276186341.spop)
	c:RegisterEffect(e4)
end
function c276186341.filter(c)
	return c:IsDefense(600) and c:IsFaceup() and c:IsAbleToHandAsCost()
end
function c276186341.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroupCount(c276186341.filter,tp,LOCATION_MZONE,0,1,nil)
	if chk==0 then return ct>0 and ct==Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0) end
	local g=Duel.SelectMatchingCard(tp,c276186341.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoHand(g,nil,REASON_COST)
	Duel.ConfirmCards(1-tp,g)
end
function c276186341.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c276186341.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c276186341.indcon(e)
	return e:GetHandler():IsPosition(POS_FACEUP_ATTACK)
end
function c276186341.lvfilter(c,tp)
	return c:IsFaceup() and c:IsLevelAbove(1) and c:IsAttribute(ATTRIBUTE_LIGHT)
		and Duel.IsExistingTarget(c276186341.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,c,c:GetLevel())
end
function c276186341.cfilter(c,lv)
	return c:IsFaceup() and c:IsLevel(lv) or c:IsRank(lv) or c:IsLink(lv) and c:IsCanAddCounter(0x1000,1)
end
function c276186341.lvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c276186341.lvfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c276186341.lvfilter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	local tc=g:GetFirst()
	e:SetLabelObject(tc)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c276186341.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,tc,tc:GetLevel())
end
function c276186341.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=e:GetLabelObject()
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local bc=tg:GetFirst()
	if bc==tc then bc=tg:GetNext() end
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsControler(tp) and bc:IsRelateToEffect(e) and bc:IsFaceup() then
		bc:AddCounter(0x1000,1)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
		e1:SetCondition(c276186341.condition)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(1)
		bc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCondition(c276186341.condition)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e2:SetCode(EFFECT_IGNORE_BATTLE_TARGET)
		e2:SetRange(LOCATION_MZONE)
		e2:SetValue(aux.imval1)
		bc:RegisterEffect(e2)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
		bc:RegisterEffect(e3)
		local e4=e1:Clone()
		e4:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
		bc:RegisterEffect(e4)
		local e5=e1:Clone()
		e5:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
		bc:RegisterEffect(e5)
		local e6=e1:Clone()
		e6:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
		bc:RegisterEffect(e6)
		local e7=Effect.CreateEffect(c)
		e7:SetType(EFFECT_TYPE_SINGLE)
		e7:SetCode(EFFECT_UNRELEASABLE_SUM)
		e7:SetCondition(c276186341.condition)
		e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e7:SetValue(1)
		e7:SetReset(RESET_EVENT+RESETS_STANDARD)
		bc:RegisterEffect(e7)
		local e8=e7:Clone()
		e8:SetCode(EFFECT_UNRELEASABLE_NONSUM)
		bc:RegisterEffect(e8)
	end
end
function c276186341.condition(e)
	return e:GetHandler():GetCounter(0x1000)>0
end
function c276186341.tgval(e,c)
	return c:GetCounter(0x1000)>0 and not c:IsImmuneToEffect(e)
end