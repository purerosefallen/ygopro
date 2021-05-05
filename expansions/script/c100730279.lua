--高速决斗技能-吾转瞬即逝的荣光
Duel.LoadScript("speed_duel_common.lua")
function c100730279.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730279.skill,c100730279.con,aux.Stringid(100730279,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730279.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetLP(tp)<=6000
		and Duel.IsExistingMatchingCard(c100730279.filter,tp,LOCATION_MZONE,0,1,nil) 
end
function c100730279.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730279)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local cg=Duel.SelectMatchingCard(tp,c100730279.cfilter,tp,LOCATION_EXTRA,0,1,1,nil,c)
	if cg:GetCount()==0 then return end
	Duel.ConfirmCards(1-tp,cg)
	local g=Duel.SelectMatchingCard(tp,c100730279.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local c=g:GetFirst()
	local code1,code2=cg:GetFirst():GetOriginalCodeRule()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ADD_LINK_CODE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e1:SetValue(code1)
	c:RegisterEffect(e1)
	if code2 then
		local e2=e1:Clone()
		e2:SetValue(code2)
		c:RegisterEffect(e2)
	end
	local e3=e1:Clone()
	e3:SetCode(EFFECT_ADD_LINK_ATTRIBUTE)
	e3:SetValue(cg:GetFirst():GetOriginalAttribute())
	c:RegisterEffect(e3)
	local e4=e1:Clone()
	e4:SetCode(EFFECT_ADD_LINK_RACE)
	e4:SetValue(cg:GetFirst():GetOriginalRace())
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(100730279,1))
	e5:SetCategory(CATEGORY_ATKCHANGE)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetProperty(EFFECT_FLAG_DELAY)
	e5:SetCode(EVENT_BE_MATERIAL)
	e5:SetCondition(c100730279.atkcon)
	e5:SetOperation(c100730279.atkop)
	c:RegisterEffect(e5)
	e:Reset()
end
function c100730279.cfilter(c)
	return c:IsType(TYPE_LINK)
end
function c100730279.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function c100730279.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_GRAVE) and r==REASON_LINK
end
function c100730279.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=c:GetReasonCard()
	if Duel.SelectYesNo(tp,aux.Stringid(100730279,1)) then
		if rc:IsFaceup() and rc:IsLocation(LOCATION_MZONE) then
			Duel.Hint(HINT_CARD,1-tp,100730279)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(c:GetAttack())
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			rc:RegisterEffect(e1)
			local e2=Effect.GlobalEffect()   
			e2:SetType(EFFECT_TYPE_FIELD)
			e2:SetCode(EFFECT_CHANGE_DAMAGE)
			e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
			e2:SetTargetRange(0,1)
			e2:SetValue(c100730279.damval)
			e2:SetReset(RESET_PHASE+PHASE_END)
			Duel.RegisterEffect(e2,tp)
		end
	end
end
function c100730279.damval(e,re,val,r,rp,rc)
	return math.floor(val/2)
end