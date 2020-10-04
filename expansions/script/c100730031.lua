--高速决斗技能-电子流派
Duel.LoadScript("speed_duel_common.lua")
function c100730031.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730031.skill,c100730031.con,aux.Stringid(100730031,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730031.filter(c)
	return c:GetSequence()<5
end

function c100730031.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local num=math.floor((4000-Duel.GetLP(tp))/1000)
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetLP(tp)<=3000
		and Duel.GetMZoneCount(tp)>0
end
function c100730031.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730031)
	local num=math.floor((4000-Duel.GetLP(tp))/1000)
	local max=3-Duel.GetMatchingGroupCount(c100730031.filter,tp,LOCATION_MZONE,0,nil)
	if num>max then num=max end
	while num>0 do
		local c=Duel.CreateToken(tp,26439287)
		Duel.MoveToField(c,tp,tp,LOCATION_MZONE,POS_FACEUP_ATTACK,true)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(1)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
		c:RegisterEffect(e2)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
		c:RegisterEffect(e3)
		local e5=e1:Clone()
		e5:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
		c:RegisterEffect(e5)
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_UNRELEASABLE_SUM)
		e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e4:SetValue(1)
		e4:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e4)
		local e5=e1:Clone()
		e5:SetCode(EFFECT_UNRELEASABLE_NONSUM)
		c:RegisterEffect(e5)
		num=num-1
	end
	e:Reset()
end