--高速决斗技能-无人能挡的恐龙之力
Duel.LoadScript("speed_duel_common.lua")
function c100730224.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730224.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730224.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(PHASE_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetOperation(c100730224.op)
	Duel.RegisterEffect(e1,tp)
	e:Reset()
end
function c100730224.op(e,tp)
	local g=Duel.GetMatchingGroup(c100730224.filter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()==0 then return end
	local tc=g:GetFirst()
	Duel.Hint(HINT_CARD,1-tp,100730224)
	while tc do
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(200)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		tc:RegisterEffect(e1)
		local e2=Effect.Clone(e1)
		e1:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
end
function c100730224.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup() and c:IsRace(RACE_DINOSAUR)
end