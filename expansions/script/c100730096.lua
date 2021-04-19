--高速决斗技能-元素合体！
Duel.LoadScript("speed_duel_common.lua")
function c100730096.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730096.skill,c100730096.con,aux.Stringid(100730096,2))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730096.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.GetMatchingGroup(c100730096.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,nil,tp)
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsPlayerCanSpecialSummon(tp)
		and Duel.GetMZoneCount(tp)>0
		and not Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_MZONE,0,1,nil,25833572)
		and g:GetClassCount(Card.GetCode)>=3
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_HAND,0,1,nil,25833572)
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,2,nil)
end
function c100730096.spfilter(c)
	return c:IsCode(98434877) or c:IsCode(62340868) or c:IsCode(25955164)
end
function c100730096.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730096)
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_HAND,0,2,nil)
	local c=g:Select(tp,2,2,nil)
	Duel.SendtoDeck(c,nil,2,REASON_RULE)
	local sg=Duel.GetMatchingGroup(c100730096.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,nil)
	local g1=sg:Select(tp,3,3,nil)
	if g1:GetClassCount(Card.GetCode)<=2 then Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730096,0)) return end
	local g2=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil,25833572)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=g2:GetFirst()
	tc:SetUniqueOnField(1,1,aux.FilterBoolFunction(Card.IsCode,25833572),LOCATION_MZONE)
	Duel.SpecialSummonStep(tc,0,tp,tp,true,true,POS_FACEUP)
	local e1=Effect.CreateEffect(tc)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ADD_TYPE)
	e1:SetValue(TYPE_XYZ)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	tc:RegisterEffect(e1,true)
	local e2=Effect.GlobalEffect()   
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CHANGE_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(0,1)
	e2:SetValue(c100730096.damval)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
	Duel.Overlay(tc,g1)
	local e3=Effect.CreateEffect(tc)
	e3:SetDescription(aux.Stringid(100730096,1))
	e3:SetCode(EFFECT_SET_ATTACK)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetHintTiming(TIMING_DAMAGE_STEP,TIMING_DAMAGE_STEP+TIMINGS_CHECK_MONSTER)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCost(c100730096.cost)
	e3:SetTarget(c100730096.target)
	e3:SetOperation(c100730096.operation)
	tc:RegisterEffect(e3)
	local e4=Effect.CreateEffect(tc)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EFFECT_DESTROY_REPLACE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTarget(c100730096.reptg)
	tc:RegisterEffect(e4)
	Duel.SpecialSummonComplete()
end
function c100730096.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c100730096.filter(c)
	return c:IsFaceup() and c:GetAttack()>0
end
function c100730096.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c100730096.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100730096.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c100730096.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,g,1,0,0)
end
function c100730096.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and tc:GetAttack()>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
function c100730096.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReason(REASON_BATTLE+REASON_EFFECT) and not c:IsReason(REASON_REPLACE) and c:CheckRemoveOverlayCard(tp,1,REASON_EFFECT) end
	if Duel.SelectEffectYesNo(tp,e:GetHandler(),96) then
		c:RemoveOverlayCard(tp,1,1,REASON_EFFECT)
		return true
	else return false end
end
function c100730096.damval(e,re,val,r,rp,rc)
	return math.floor(val/2)
end